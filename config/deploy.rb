gem 'brightbox', '>=2.3.5'
gem 'capistrano-ext', '>=1.2.1'
require 'brightbox/recipes'
require 'brightbox/passenger'

# Multistage deployment
set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "redmine"
set :keep_releases, 5
set :scm_verbose, true
set :deploy_via, :remote_cache
set :repository, "git@github.com:lloydpick/redmine.git"
set :scm, :git
set :local_shared_files, %w(config/database.yml config/email.yml files config/initializers/session_store.rb)

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :rails_env, 'production'
set :user, "limi"
server "andromeda.limi.co.uk", :app, :web, :db, :primary => true

set(:deploy_to) { File.join("", "home", "limi", "domains", "bugs.limi.co.uk", stage.to_s) }