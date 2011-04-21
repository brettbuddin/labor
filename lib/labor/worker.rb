module Labor
  class Worker
    include Helpers

    def initialize(*abilities)
      @worker = Gearman::Worker.new
      add_abilities(abilities)
    end

    # Starts the work loop.
    #
    # Returns nothing.
    def work
      @worker.job_servers = Labor.servers
      register_signals
      loop { @worker.work or break }
    end

    private

    # Registers abilities with the worker and announces them to the server.
    # 
    # abilities - The Array of ability strings.
    #
    # Returns nothing.
    def add_abilities(abilities)
      abilities.each do |ability|
        klass = constantize(classify(remove_meta_data(ability)))
        config = Labor.config

        @worker.add_ability(ability) do |data, job|
          begin
            payload = JSON.parse data
            instance = klass.new(payload, job)
            instance.instance_variable_set(:@config, config)
            instance.perform
          rescue Exception => e
            backtrace = Array(e.backtrace)[0..500]
            log "Job failed: #{e.inspect}"
            log backtrace.join("\n")
            return false
          end
        end

        if klass.respond_to?(:after_perform)
          @worker.after_ability(ability) do |result, data|
          begin
            payload = JSON.parse data
            klass.after_perform(payload, result)
          rescue Exception => e
            backtrace = Array(e.backtrace)[0..500]
            log "After job failed: #{e.inspect}"
            log backtrace.join("\n")
          end
          end
        end
      end
    end

    # Registers trapping signals with the worker.
    #
    # Returns nothing.
    def register_signals
      %w(INT TERM).each do |signal|
        trap signal do
          @worker.worker_enabled = false
          if @worker.status == :waiting
            trap signal, "DEFAULT"
            exit
          end
        end
      end
    end

    private

    # Removes the meta data from an ability name.
    #
    # name - The String name of the ability.
    #
    # Returns the String name of the ability with the
    # meta data removed. (e.g. "ability_name[123]" => "ability_name")
    def remove_meta_data(name)
      matches = name.match(/(.*)\[.*\]/)
      return matches[1] unless matches.nil?
      name
    end
  end
end
