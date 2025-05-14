# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/d-drive/projects/web-development/personal-projects/expenzeio/expenzeIo-server"

# Create session with specified name if it does not already exist.
# If no argument is given, session name will be based on layout file name.
if initialize_session "expenzeio-server"; then

  # Window 0: editor 
  new_window "editor"
  run_cmd "nvim ./app/main.go"

  # Window 1: server 
  new_window "server"
  run_cmd "air" 

  # Window 2: yazi file manager 
  new_window "yazi"
  run_cmd "yazi"  
  
  # Window 3: git manager
  new_window "git-manager"
  # run_cmd "lazygit"

  # Window 3: docker manager
  new_window "docker-manager"
  # run_cmd "lazydocker"
 
  # Window 4: db 
  new_window "postgres"
  run_cmd "sudo -i -u postgres psql"

#   run_cmd "sudo docker run -d \ --name pgadmin \
#   --rm \
#   -e 'PGADMIN_DEFAULT_EMAIL=sadiqhasanrupani11@gmail.com' \
#   -e 'PGADMIN_DEFAULT_PASSWORD=sadiq123' \
#   -p 5050:80 \
#   -v /home/shrupani/D-drive/postgres/servers.json:/pgadmin4/servers.json \
#   -v /home/shrupani/D-drive/postgres/.pgpass:/pgpassfile \
#   dpage/pgadmin4
# "  
# # Show all Docker containers in the top pane

  # split_v 50  # Split the bottom pane
  # select_pane 1  # Go to the new pane
  # run_cmd "sudo docker start pgadmin"  # Start Docker containers
  #
  # select_pane 2
  # run_cmd "sudo docker start postgres-db"

  # Optionally, select the first window (server) after starting the Docker window
  select_window 0

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
