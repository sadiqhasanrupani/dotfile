# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "/home/sadiqhasan/d-drive/Work/Freelance/Sohail Ecommerce/project/backend/magic-pages-go-service"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "magic-pages"; then

  # Window 0: editor
  new_window "editor"
  run_cmd "nvim ./app/main.go"

  # Window 1: server
  new_window "server"
  select_pane 0
  run_cmd "make run"

  # Window 2: yazi file manager
  new_window "yazi"
  run_cmd "yazi"

  # Window 3: git manager
  new_window "git-manager"
  # run_cmd "lazygit"
  
  # Window 4: docker manager
  new_window "docker-manager"
  # run_cmd "lazydocker"

  # Window 5: postgres_db 
  new_window "postgres_db"
  run_cmd "sudo -i -u postgres psql"

  select_window 0 

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
