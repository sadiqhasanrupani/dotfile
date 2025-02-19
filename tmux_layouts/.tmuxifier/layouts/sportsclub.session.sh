# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/D-drive/projects/freelance stuff/sportsclub/sportsclub-client"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "sportsclub"; then

  # Create a new window inline within session layout definition.
  new_window "frontend"

  # Load a defined window layout.
  select_window 0
  split_v 10
  select_pane 0
  run_cmd "nvim ./src/App.jsx"

  select_pane 1
  run_cmd "npm run dev"

  new_window "backend"

  split_v 10
  select_pane 0
  run_cmd "cd .. && cd ./SportsClubApi && dotnet run"
  select_pane 1
  run_cmd "sqlcmd -S localhost -U SA -P 'YourPassword123' -C"
  
  select_window 0

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
