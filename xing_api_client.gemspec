# coding: utf-8
require File.expand_path('../lib/xing_api_client/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "xing_api_client"
  spec.version       = XingApiClient::VERSION
  spec.authors       = ["Martin Brendel"]
  spec.email         = ["ependichter@gmail.com"]
  spec.description   = %q{Wrapper for the XING API}
  spec.summary       = %q{An easy way to access the XING API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "debugger"
  spec.add_dependency "bundler", "~> 1.3"
  spec.add_dependency "rake"
  spec.add_dependency "oauth"
  spec.add_dependency "multipart-post"
  spec.add_dependency "activesupport"
  spec.add_dependency "parallel"
  spec.add_dependency "mimemagic"
  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "simple_oauth"
end
