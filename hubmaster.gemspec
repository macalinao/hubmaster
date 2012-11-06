# -*- encoding: utf-8 -*-
require File.expand_path('../lib/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tommy Schaefer"]
  gem.email         = ["me@tommyschaefer.net"]
  gem.description   = %q{Hubmaster is a tool built in ruby that allows github interactions to be made outside the browser.}
  gem.summary       = %q{Hubmaster is simple and easy to use. Visit the github page for more details.}
  gem.homepage      = "https://github.com/tommyschaefer/hubmaster"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hubmaster"
  gem.version       = Github::VERSION
  gem.add_dependency "highline"
end
