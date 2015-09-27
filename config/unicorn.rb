APP_ROOT = File.expand_path(File.dirname(File.dirname(__FILE__)))

worker_processes 2
working_directory APP_ROOT
preload_app true
timeout 30

rails_env = ENV['RAILS_ENV'] || 'production'

listen '/tmp/unicorn.sock', :backlog => 64
pid '/tmp/unicorn.pid'

stderr_path APP_ROOT + '/tmp/log/unicorn.error.log'
stdout_path APP_ROOT + '/tmp/log/unicorn.out.log'

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!

  old_pid = '/tmp/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts 'Old master already dead'
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
