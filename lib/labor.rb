require 'gearman'
require 'json'

require 'labor/version'
require 'labor/core_ext'
require 'labor/helpers'
require 'labor/worker'
require 'labor/config'

module Labor
  # Sets the server addresses that we'd like to connect to.
  #
  # servers - The String address of the server or an Array 
  #   of server addresses.
  # 
  # Examples
  #
  #   Labor.servers '10.3.4.19:4730'
  #   Labor.servers ['10.3.4.19:4730', '10.3.4.20:4730']
  #
  # Returns the Array of server addresses or String if only one was given.
  def self.servers=(servers)
    @servers = servers 
  end

  # Returns the list of server addresses we'd like to connect to.
  #
  # Returns the Array of server addresses. Defaults to localhost:4730 
  #   if nothing has been set.
  def self.servers
    @servers || ["localhost:#{Gearman::Util::DEFAULT_PORT}"]
  end

  # Loads in a config file.
  #
  # file_name - The String path to the file.
  #
  # Examples
  #
  #   Labor.config 'settings.rb'
  #
  # Returns the Labor::Config instance.
  def self.config=(file_name)
    @config = Labor::Config.new.load file_name
  end

  # Returns the configuration object for our application.
  #
  # Returns the Labor::Config instance. Defaults to a new config
  #   if nothing has been set.
  def self.config
    @config ||= Labor::Config.new
  end

  class << self
    attr_accessor :verbose 
  end
end
