# Configuration manager for the worker. Treat it like a Hash.
# A hash that has a tiny DSL for setting values to it and 
# supports grouping.
#
# For example:
#
#   config = Config.new
#   config[:foo] = "bar"
#   config.set :hello, "world"
#   config.group :a_group do
#     set :three_two_one, "let's jam!"
#   end
#
#   config.foo #=> "bar"
#   config.hello #=> "world"
#   config.a_group.three_two_one #=> "let's jam"
#
module Labor
  class Config
    include Enumerable

    def initialize
      @config = {}
    end

    # Loads a config file.
    #
    # file_name - The String path to the file.
    #
    # Returns Config instance.
    def load(file_name)
      instance_eval(File.read(file_name))
      self
    end
      
    # Assigns a value to a key.
    #
    # key - The Symbol key name.
    # value - Anything you'd like to assign to the key.
    #
    # Returns the value of the key.
    def set(key, value)
      @config[key.to_sym] = value
    end
    alias_method :[]=, :set

    # Retreives the value of a key.
    #
    # key - The Symbol key name.
    #
    # Returns the value of the key.
    def get(key)
      @config[key.to_sym] 
    end
    alias_method :[], :get

    # Deletes a key from the config.
    #
    # key - The Symbol key name.
    #
    # Returns the value of the key.
    def delete(key)
      @config.delete key.to_sym
    end

    # Checks if a key is set in the config.
    #
    # key - The Symbol key name.
    #
    # Returns a Boolean of whether or not the key exists.
    def exists?(key)
      @config.has_key? key.to_sym
    end

    # Call a block for each key in the config.
    #
    # block - The Block to execute for each element.
    #
    # Returns a Boolean of whether or not the key exists.
    def each(&block)
      @config.each(&block)
    end


    # Checks if a key is set in the config.
    #
    # key - The Symbol key name
    #
    # Returns a Boolean of whether or not the key exists.
    def group(key, &block)
      @config[key.to_sym] = Config.new
      @config[key.to_sym].instance_eval(&block) if block_given?
    end

    private

    def method_missing(sym, *args)
      if args.length == 0 && @config.has_key?(sym)
        get(sym)
      end
    end
  end
end
