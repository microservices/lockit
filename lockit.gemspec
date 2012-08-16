# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "lockit/version"

Gem::Specification.new do |s|
  s.name        = %q{lockit}
  s.version     = LockIt::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chris Beer", "Bess Sadler"]
  s.email       = %q{chris@cbeer.info}
  s.homepage    = "https://github.com/microservices/lockit"
  s.summary     = %q{A ruby implementation of LockIt: A Simple File-based Convention for Resource Locking}
  s.description = %q{A ruby implementation of LockIt: A Simple File-based Convention for Resource Locking}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  
  # Bundler will install these gems too if you've checked this out from source from git and run 'bundle install'
  # It will not add these as dependencies if you require lyber-core for other projects
  s.add_development_dependency "rake"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rspec"
  s.add_development_dependency 'yard'
end
