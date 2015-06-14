environment 'production'
pidfile 'tmp/pids/puma.pid'
state_path 'tmp/pids/puma.state'
stdout_redirect 'log/puma_access.log', 'log/puma_error.log', true
bind 'unix://tmp/sockets/puma.sock'
activate_control_app 'unix://tmp/sockets/pumactl.sock'
daemonize true
workers 2
threads 0,16
preload_app!
