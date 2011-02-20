desc "Stamp a new version and push it to Rubygems.org"
task :stamp_version do
  require 'labor/version'
  
  sh "gem build labor.gemspec"
  sh "gem push labor-#{Labor::Version}.gem"
  sh "git tag v#{Labor::Version}"
  sh "git push origin v#{Labor::Version}"
  sh "git push origin master"
  sh "git clean -fd"
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
