#!/usr/bin/env puma

directory '/data/www/mayitemai/current'
rackup "/data/www/mayitemai/current/config.ru"
environment 'production'

pidfile "/data/www/mayitemai/shared/tmp/pids/puma.pid"
state_path "/data/www/mayitemai/shared/tmp/pids/puma.state"
stdout_redirect '/data/www/mayitemai/shared/log/puma_access.log', '/data/www/mayitemai/shared/log/puma_error.log', true


threads 0,16

bind 'unix:///data/www/mayitemai/shared/tmp/sockets/puma.sock'

workers 2



preload_app!

on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "/data/www/mayitemai/current/Gemfile"
end
