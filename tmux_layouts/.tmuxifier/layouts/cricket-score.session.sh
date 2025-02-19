# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/D-drive/Internship/lifease-solution/project/cricket-score-project/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "cricket-score"; then

  # Create a new window inline within session layout definition.
  new_window "server"
  split_v 20
  run_cmd "cd server && npm run start:dev"
  
  select_pane 0 
  run_cmd "cd server; nvim src/index.ts"
  
  new_window "client"
  split_v 20
  run_cmd "cd ./cricket-score-project && nvim src/App.tsx"
  split_h 50
  select_pane 1
  run_cmd "cd ./cricket-score-project && npm run dev"

  select_window 0

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
