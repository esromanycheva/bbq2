namespace :rails do
  desc "Open the rails console on one of the remote servers"
  task :console do |current_task|
    on roles(:app) do |server|
      exec %Q[ssh -l #{server.user} #{server.hostname} -p #{server.port || 22} -t 'source ~/.bashrc > /dev/null; cd #{release_path}; bin/rails console']
    end
  end
end