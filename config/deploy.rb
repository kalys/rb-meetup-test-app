require 'bundler/capistrano'
require 'rvm/capistrano'

load 'config/recipes/base'
load 'config/recipes/nginx'
load 'config/recipes/unicorn'
load 'config/recipes/check'

set :application, "test_app"
set :repository,  "https://github.com/kalys/rb-meetup-test-app.git"

set :scm, :git
set :branch, 'master'

set :user, 'vagrant'
set :use_sudo, false

set :deploy_to, "/home/vagrant/apps/#{application}"
set :deploy_via, :remote_cache

server "localhost", :web, :app, :db, :resque_worker, primary: true
set :port, 2222

set :rvm_ruby_string, "1.9.3@#{application}"
set :rvm_type, :system

set :nginx_domains, "localhost"

after "deploy", "unicorn:stop_old"

require "capistrano-unicorn"
