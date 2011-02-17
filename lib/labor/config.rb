module Labor
  class Config
    include Enumerable

    def initialize
      @config = {}
    end

    def load(file_name)
      instance_eval(File.read(file_name))
      self
    end
      
    def set(key, value)
      @config[key.to_sym] = value
    end
    alias_method :[]=, :set

    def get(key)
      @config[key.to_sym] 
    end
    alias_method :[], :get

    def delete(key)
      @config.delete key.to_sym
    end

    def exists?(key)
      @config.has_key? key.to_sym
    end

    def each(&block)
      @config.each(&block)
    end

    private

    def method_missing(sym, *args)
      if args.length == 0 && @config.has_key?(sym)
        get(sym)
      end
    end
  end
end
