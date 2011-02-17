begin
  require "jeweler"

  Jeweler::Tasks.new do |gem|
    gem.name = "labor"
    gem.version = "0.1"
    gem.summary = "Wrapper for Gearman to make workers easier to create and manage."
    gem.description = <<-desc
      Wrapper for Gearman to make workers easier to create and manage.
    desc
    gem.email = "brett@motobias.com"
    gem.homepage = "http://github.com/brettbuddin/labor"
    gem.date = Time.now.strftime('%Y-%m-%d')
    gem.authors = ["Brett Buddin"]
    gem.files = %w( README.md Rakefile LICENSE )
    gem.files += Dir["*", "{lib}/**/*"]
    gem.add_dependency "gearman-ruby"
    gem.add_dependency "json"

    gem.has_rdoc = false
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new('spec') do |t|
    t.pattern = FileList['spec/**/*_spec.rb']
  end

  task :test do
    Rake::Task['spec'].invoke
  end
end
