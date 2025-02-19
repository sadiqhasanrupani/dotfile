# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/D-drive/udemy/dsa_with_java"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "dsa"; then

  # Window 0: server
  new_window "dsa"
  run_cmd "nvim"  

  new_window "terminal"

  select_window 0

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
