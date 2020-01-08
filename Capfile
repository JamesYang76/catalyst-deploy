# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"


require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git


require "capistrano/rbenv"
require "capistrano/bundler"
require "capistrano/rails"
require "capistrano/upload-config"
require "capistrano/nginx"
require "capistrano/puma"
require "capistrano/puma/nginx"
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Nginx


# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
