module Labor
  class Ability
    include Helpers

    def initialize(payload, job)
      puts "Payload: #{payload.inspect}"
      
      @payload = payload.symbolize_keys!
      @job = job
    end
  end
end
