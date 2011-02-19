module Labor
  class Worker
    include Helpers

    def initialize(*abilities)
      @worker = Gearman::Worker.new(Labor.servers)
      add_abilities(abilities)
    end

    # Starts the work loop.
    #
    # Returns nothing.
    def work
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
        klass = constantize(classify(ability))
        klass.instance_variable_set(:@config, Labor.config)

        @worker.add_ability(ability) do |data, job|
          begin
            payload = JSON.parse data
            klass.perform(payload, job)
          rescue Exception => e
            log "Job failed: #{e.inspect}"
            return false
          end
        end

        if klass.respond_to?(:after_perform)
          @worker.after_ability(ability) do |result, data|
          begin
            payload = JSON.parse data
            klass.after_perform(payload, result)
          rescue Exception => e
            log "After job failed: #{e.inspect}"
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
        trap(signal) do
          @worker.worker_enabled = false
        end
      end
    end

  end
end
