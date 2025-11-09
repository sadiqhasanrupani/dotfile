# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "/mnt/data/projects/web-dev/edugate-major-project"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "edugate"; then

  # Create a new window inline within session layout definition.
  new_window "client"
  split_v
  split_h
  select_pane 1
  run_cmd "cd client && npm start"
 
  new_window "server"
  split_v
  run_cmd "cd server && npm run watch-tsc"
  split_h
  run_cmd "cd server && npm run dev"

  # Load a defined window layout.
  #load_window "example"

  # Select the default active window on session creation.
  select_window 0
  select_pane 0
  run_cmd "cd client && nvim src/App.jsx"

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
