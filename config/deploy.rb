# config valid for current version and patch releases of Capistrano
lock "~> 3.11.2"

set :application, "catalyst-deploy"
set :repo_url, "git@github.com:JamesYang76/catalyst-deploy.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :user, "deploy"


# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml","config/secrets.yml",".env"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
set :default_env, path: "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"

set :rbenv_type, :user

set :rbenv_ruby, File.read(".ruby-version").strip

set :rbenv_prefix,
    "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"

set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :rbenv_roles, :all # default value

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
# Don't change these unless you know what you're doing
set :pty,             true

set :config_example_suffix, '.example'
set :config_files, fetch(:linked_files)

set :puma_threads, [4, 16]
set :puma_workers, 0
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_env, fetch(:rack_env, fetch(:rails_env, "production"))
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

after "deploy:published", "nginx:restart"

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
# bundle exec pumactl -S /home/deploy/catalyst-deploy/shared/tmp/pids/puma.state -F /home/deploy/catalyst-deploy/shared/puma.rb restart
#
#
#  bundle exec puma -C /home/deploy/catalyst-deploy/shared/puma.rb --daemon