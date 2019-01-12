# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "Register"
set :repo_url, "git@github.com:eventfuel/Register.git"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/register.eventacc.es"

# default env for NODE
# set :default_env, { 'NODE_ENV' => 'production' }

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, ".env"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
# ensure Webpack build output and NPM package installation via yarn are shared across deploys.
append :linked_dirs, 'public/packs', 'node_modules'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# Crono setup
set :crono_pid, -> { File.join(shared_path, "tmp", "pids", "crono.pid") }
set :crono_env, -> { fetch(:rack_env, fetch(:rails_env, fetch(:stage))) }
set :crono_log, -> { File.join(shared_path, "log", "crono.log") }
set :crono_role, -> { :app }

desc "Check if agent forwarding is working"
task :forwarding do
  on roles(:all) do |h|
    if test("env | grep SSH_AUTH_SOCK")
      info "Agent forwarding is up to #{h}"
    else
      error "Agent forwarding is NOT up to #{h}"
    end
  end
end
