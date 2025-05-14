# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/d-drive/projects/applications/nxtdoor-app/nxtdoor-backend"


# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "nxtdoor-backend"; then

  # Window 0: editor 
  new_window "editor"
  run_cmd "nvim ./src/main.ts"

  # Window 1: server 
  new_window "server"
  split_v 50  # Split vertically, giving 50% to the new pane
  run_cmd "npm run doc" 

  split_h 50  
  select_pane 0  
  run_cmd "npm run start:dev"

  # Window 2: yazi file manager 
  new_window "yazi"
  # run_cmd "yazi"  

  # Window 3: git manager
  new_window "git-manager"
  # run_cmd "lazygit"

  # Window 3: docker manager
  new_window "docker-manager"
  # run_cmd "lazydocker"
 
  # Window 4: db 
  new_window "db"
  # run_cmd "sudo -i -u postgres psql"

  select_window 0

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
