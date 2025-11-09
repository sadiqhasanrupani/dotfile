#!/usr/bin/env bash
set -euo pipefail

# Config file (optional): ~/.config/droidcam/config
# You may set PHONE_IP, PHONE_PORT, AUTO_CONNECT in that file or via environment
CFG="$HOME/.config/droidcam/config"
if [ -f "$CFG" ]; then
  # shellcheck disable=SC1090
  source "$CFG"
fi

: "${PHONE_IP:-}"      # optionally set, e.g. 10.200.137.116
: "${PHONE_PORT:-4747}"# default port
: "${AUTO_CONNECT:-false}" # true/false

# Packages to ensure
PKGS=(droidcam v4l2loopback-dkms v4l2loopback-utils)

command_exists() { command -v "$1" >/dev/null 2>&1; }

install_missing_pkgs() {
  # require 'yay' for AUR installs
  if ! command_exists yay; then
    echo "[droidcam-setup] 'yay' not found — please install yay if you want automatic AUR installs."
    return 0
  fi

  for pkg in "${PKGS[@]}"; do
    if ! pacman -Qq "$pkg" >/dev/null 2>&1; then
      echo "[droidcam-setup] Installing missing package: $pkg"
      yay -S --noconfirm "$pkg"
    fi
  done
}

# kill processes using a device (if any)
kill_using_device() {
  local dev="$1"
  if sudo fuser -v "$dev" >/dev/null 2>&1; then
    echo "[droidcam-setup] Killing processes using $dev"
    # get PIDs and kill them
    sudo fuser -k "$dev" || true
    sleep 0.5
  fi
}

reload_v4l2loopback() {
  echo "[droidcam-setup] Reloading v4l2loopback module with two devices..."
  # safely try to remove module if not in use
  if lsmod | grep -q '^v4l2loopback'; then
    # if in use, try killing processes for /dev/video2 first
    kill_using_device /dev/video2 || true
    # attempt remove (may fail if still in use)
    sudo modprobe -r v4l2loopback || true
  fi

  # load two devices: video_nr=2,10
  sudo modprobe v4l2loopback video_nr=2,10 card_label="DroidCam","OBS Virtual Camera" exclusive_caps=1 max_buffers=8
}

configure_caps_and_audio() {
  # only run v4l2loopback-ctl if present and device exists
  if command_exists v4l2loopback-ctl && [ -e /dev/video2 ]; then
    echo "[droidcam-setup] Setting /dev/video2 caps -> YU12 1280x720, fps 30"
    sudo v4l2loopback-ctl set-caps /dev/video2 "YU12:1280x720" || true
    sudo v4l2loopback-ctl set-fps /dev/video2 30 || true
  fi

  # audio loopback
  if ! lsmod | grep -q snd_aloop; then
    echo "[droidcam-setup] Loading snd_aloop (audio loopback)..."
    sudo modprobe snd_aloop || true
  fi
}

start_droidcam_client_if_configured() {
  if [ "${AUTO_CONNECT}" = "true" ] || [ -n "${PHONE_IP:-}" ]; then
    if ! command_exists droidcam-cli; then
      echo "[droidcam-setup] droidcam-cli not found; skipping auto-connect."
      return
    fi
    if [ -z "${PHONE_IP:-}" ]; then
      echo "[droidcam-setup] PHONE_IP not set; skipping auto-connect."
      return
    fi

    # if droidcam-cli already running, skip
    if pgrep -x droidcam-cli >/dev/null 2>&1; then
      echo "[droidcam-setup] droidcam-cli already running; skipping start."
      return
    fi

    echo "[droidcam-setup] Starting droidcam-cli -> ${PHONE_IP}:${PHONE_PORT} (background)."
    nohup droidcam-cli "${PHONE_IP}" "${PHONE_PORT}" >/dev/null 2>&1 &
  fi
}

# alias for manual reset
alias fixcams='sudo pkill -f droidcam-cli || true; sudo pkill -f obs || true; sudo modprobe -r v4l2loopback || true; sudo modprobe v4l2loopback video_nr=2,10 card_label="DroidCam","OBS Virtual Camera" exclusive_caps=1 max_buffers=8; sudo v4l2loopback-ctl set-caps /dev/video2 "YU12:1280x720" || true; sudo v4l2loopback-ctl set-fps /dev/video2 30 || true; sudo modprobe snd_aloop || true; echo "[droidcam-setup] fixcams completed."'

# Run setup only when the module or devices are missing
need_setup=false
if ! lsmod | grep -q '^v4l2loopback'; then
  need_setup=true
fi
if [ ! -e /dev/video2 ] || [ ! -e /dev/video10 ]; then
  need_setup=true
fi

if [ "$need_setup" = true ]; then
  # Try to install missing packages (non-fatal)
  install_missing_pkgs || true

  # Reload/create devices
  reload_v4l2loopback

  # configure caps and audio
  configure_caps_and_audio

  # optionally start the droidcam client in the background if PHONE_IP set
  start_droidcam_client_if_configured

  echo "[droidcam-setup] Setup finished."
fi

# Export useful variables/alias for user sessions
export DROIDCAM_VIDEO_DEV="/dev/video2"
export DROIDCAM_OBS_DEV="/dev/video10"
export -f start_droidcam_client_if_configured
