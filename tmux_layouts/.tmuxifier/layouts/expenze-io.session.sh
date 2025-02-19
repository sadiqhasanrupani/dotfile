# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/D-drive/projects/ExpenzeIO"

# Create session with specified name if it does not already exist.
# If no argument is given, session name will be based on layout file name.
if initialize_session "expenze-io"; then

  # Window 0: server
  new_window "server"
  split_v 20  # Split vertically, giving 20% to the new pane
  run_cmd "cd expenze-io-server && air"  # Start the server in the top pane

  split_h 50  # Split the bottom pane horizontally into two
  
  run_cmd "sudo -i -u postgres psql"
  split_h
  run_cmd "sudo systemctl start postgresql"

  select_pane 0  # Go back to the top pane
  run_cmd "cd expenze-io-server; nvim ./app/main.go"

  # Window 1: docker
  new_window "docker"
  split_v 20 
  select_pane 0

  # Window 2: flutter
  new_window "flutter"
  select_pane 0
  run_cmd "cd expenze_io"

  # Window 3: react
  new_window "react"
  select_pane 0
  run_cmd "cd expenze-io-web"

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
