# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/d-drive/projects/web-development/personal-projects/sadiqhasan-fullstack-dev"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "portfolio"; then

  # Create a new window inline within session layout definition.
  new_window "my_portfolio"

  # Load a defined window layout.
  select_window 0
  split_v 10 
  select_pane 0
  run_cmd "nvim ./src/App.tsx" 

  select_pane 1
  run_cmd "npm run dev"
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
