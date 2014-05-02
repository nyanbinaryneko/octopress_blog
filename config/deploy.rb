ssh_options[:forward_agent] = true
require "bundler/capistrano"

set :keep_releases, 5
set :scm, :git
set :scm_verbose, false

# Set your repository URL
set :repository, "git@github.com:alikoneko/octopress_blog.git"

# Set your application name
set :application, "alineer.com"
set :deploy_via, :remote_cache

# Set your machine user
set :user, 'aneer'

set :deploy_to, "/home/#{user}/apps/#{application}"
set :use_sudo, false

# Set your host, you can use the server IPs here if you don't have one yet
role :app, 'alineer.com', :primary => true

default_run_options[:pty] = true

namespace :octopress do
  task :generate, :roles => :app do
    run "cd #{release_path} && bundle exec rake generate"
  end
end

after 'deploy:update_code', 'deploy:cleanup'
after 'bundle:install', 'octopress:generate'