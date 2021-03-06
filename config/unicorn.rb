# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "."

# Unicorn PID file location
pid "./pids/unicorn.pid"

# Path to logs
stderr_path "/apps/log/happiness_service_unicorn_error.log"
stdout_path "/apps/log/happiness_service_unicorn.log"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30
