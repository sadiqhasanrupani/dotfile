# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/D-drive/projects/eye-crest/server"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "eye-crest-server"; then

  # Create a new window inline within session layout definition.
  new_window "server"
  run_cmd ""

  new_window "file-manager"
  run_cmd "yazi"

  new_window "git-manager"
  run_cmd "lazygit"

  # Load a defined window layout.
  # load_window "server"

  # Select the default active window on session creation.
  select_window 0

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
