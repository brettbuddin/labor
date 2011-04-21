# Labor

A wrapper for "gearman-ruby" which provides an easy mechanism for managing your jobs. Jobs are just Ruby classes which respond to the `perform` method.

## Install

    gem install labor

## Get Started

Basic `Rakefile`:
  
    require 'labor'
    require 'labor/tasks'

    class TestJob
      def perform
        puts "Hello, world!"

        true
      end
    end

    class AnotherTest
      def perform
        puts "Hello, world... again!"

        true
      end
    end

    Labor.servers = ["10.0.0.1:4370", "10.0.0.2:4370"]

Let's run the worker:

    $ export ABILITIES=test-job,another-test
    $ rake labor:work

The `ABILITIES` environment variable can accept multiple job names; each seperated by a comma. 

Job names can also carry meta data associated with that particular worker. Meta data is any information that shouldn't affect what you name the job class in your system, but indicate to Gearman that this worker is unique. You can do this by putting your meta data inside `[` and `]` in the ability name. For example: `email[123]`. Everything within and including the `[]` symbols will be removed when referencing your worker class' `perform` method.

## Configuration

Labor also allows you to load in a configuration file along with your worker. This configuration file is written in Ruby and offers a simple DSL (similar to the one present in Capistrano) for setting variables.

Configs look like this:
   
    # settings.rb

    set :foo, "bar"
    set :i_am, "at the #{bar}"

    group :credentials do
      set :username, "murkturgler"
      set :password, "supersecret"
    end


The config file would then be loaded in like this:

    Labor.config File.join(File.dirname(__FILE__), 'settings.rb')

When the worker is started up, Labor will load this config into the `@config` instance variable of your job class/module. You'll then be able to retrieve keys from the config within your job.

    class TestJob
      def self.perform
        puts "Hey! I'm #{@config[:i_am]}"
        #=> "Hey! I'm at the bar"

        puts "Here's my username: #{@config.credentials.username}"
        #=> "Here's my username: murkturgler"

        true
      end
    end
