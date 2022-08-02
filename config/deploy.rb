# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "bbq2"
set :repo_url, "git@github.com:esromanycheva/bbq2.git"
# Also works with non-github repos, I roll my own gitolite server
set :deploy_to, "/home/deploy/#{fetch :application}"
set :rbenv_prefix, '/usr/bin/rbenv exec' # Cf issue: https://github.com/capistrano/rbenv/issues/96
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'