APP_ROOT = '/home/deploy/mayitemai'
pidfile "#{APP_ROOT}/tmp/pids/puma.pid"
state_path "#{APP_ROOT}/tmp/pids/puma.state"
daemonize true
workers 2
threads 4,8
preload_app!
