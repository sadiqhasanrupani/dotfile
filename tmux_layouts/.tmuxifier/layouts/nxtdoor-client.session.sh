# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/d-drive/projects/applications/nxtdoor-app/nxtdoor"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "nxtdoor-client"; then

  # Window 0: editor 
  new_window "editor"
  run_cmd "nvim ./src/app/page.tsx"

  # Window 1: server 
  new_window "client-server"
  run_cmd "npm run dev" 

  # Window 2: yazi file manager 
  new_window "yazi"
  # run_cmd "yazi"  

  # Window 3: git manager
  new_window "git-manager"
  # run_cmd "lazygit"

  # Window 3: docker manager
  new_window "docker-manager"
  # run_cmd "lazydocker"
 
  select_window 0

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
