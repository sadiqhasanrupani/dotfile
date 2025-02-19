# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/D-drive/projects/freelance stuff/glory-fitness"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "glory-gym"; then

  # Window 0: server
  new_window "server"
  split_v 20  # Split vertically, giving 20% to the new pane
  run_cmd "cd glory-gym-server && npm run dev"  # Start the server in the top pane

  split_h 50  # Split the bottom pane horizontally into two
  
  run_cmd "sudo -i -u postgres psql"
  split_h
  run_cmd "sudo systemctl start postgresql"

  select_pane 0  # Go back to the top pane
  run_cmd "cd glory-gym-server; nvim ./server.js"

  # Window 1: sass web app 
  new_window "sass-web-app"
  split_v 20  # Split vertically, giving 20% to the new pane
  run_cmd "cd glory-gym-management-software && npm run dev"  

  split_h 50  
  
  select_pane 0  
  run_cmd "cd glory-gym-management-software; nvim ./src/App.jsx"

  # Window 2: website 
  new_window "website"
  split_v 20  
  run_cmd "cd glory-gym-website && npm run dev"  

  split_h 50  
  select_pane 0  
  run_cmd "cd glory-gym-website; nvim ./src/App.jsx"

  select_window 0

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
