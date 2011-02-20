require 'labor/version'

Gem::Specification.new do |s|
  s.name = "labor"
  s.version = Labor::Version

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brett Buddin"]
  s.date = Time.now.strftime("%Y-%m-%d")
  s.summary = %q{More portable jobs for Gearman workers.}
  s.description = "Wrapper for gearman-ruby that provides a different, and more portable, way of defining jobs."
  s.email = "brett@intraspirit.net"
  s.homepage = "http://github.com/brettbuddin/labor"

  s.files = [
    "LICENSE",
    "README.md",
    "Rakefile"
  ]
  s.files += Dir.glob("lib/**/*") 
  s.files += Dir.glob("spec/**/*") 
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]

  s.require_paths = ["lib"]
  s.test_files = [
    "spec/config_spec.rb",
    "spec/files/sample_config.rb",
    "spec/labor_spec.rb",
    "spec/spec_helper.rb",
    "spec/worker_spec.rb"
  ]

  s.add_dependency "gearman-ruby", ">= 0"
  s.add_dependency "json", ">= 0"
end

