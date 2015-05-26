APP_ROOT = '/home/deploy/mayitemai'
pidfile "#{APP_ROOT}/tmp/pids/puma.pid"
state_path "#{APP_ROOT}/tmp/pids/puma.state"
bind 'unix://tmp/sockets/puma.sock'
activate_control_app 'unix://tmp/sockets/pumactl.sock'
daemonize true
workers 2
threads 4,8
preload_app!
