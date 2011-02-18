# Rake tasks for Labor
#
# require 'labor/tasks'

namespace :labor do
  task :work do
    require 'labor'

    abilities = ENV['ABILITIES'].to_s.split(',')

    unless abilities.empty?
      worker = Labor::Worker.new *abilities
    else
      abort "Please set ABILITIES environment variable (e.g. ABILITIES=say-hai,say-hello)"
    end

    if ENV['PIDFILE']
      File.open(ENV['PIDFILE'], 'w') { |f| f << Process.pid.to_s }
    end
    Labor.verbose = ENV['VERBOSE']

    worker.work
  end
end
