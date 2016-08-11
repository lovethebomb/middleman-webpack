# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "middleman-webpack/version"

Gem::Specification.new do |s|
  s.name        = "middleman-webpack"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lucas Heymès"]
  s.email       = ["lucas@lovethebomb.eu"]
  s.homepage = "https://github.com/lovethebomb/middleman-webpack"
  s.summary     = %q{middleman-webpack creates a ws to trigger client reload}
  s.description     = %q{middleman-webpack creates a ws to trigger client reload}

  s.license = "MIT"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 3.3.12"])

  # Additional dependencies
  s.add_runtime_dependency('em-websocket', ['~> 0.5.1'])
end
