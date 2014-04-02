# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multidb/version'

Gem::Specification.new do |spec|
  spec.name          = "multidb"
  spec.version       = Multidb::VERSION
  spec.authors       = ["nakamura shinichirou"]
  spec.email         = ["naka5313@gmail.com"]
  spec.summary       = %q{DBのマスター・スレーブの切り替えを簡単にできるようにするプラグイン.}
  spec.description   = %q{DBのマスター・スレーブの切り替えを簡単にできるようにするプラグイン.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake" , " ~> 10.1"
  spec.add_development_dependency "activerecord", "~> 4.0.3"
end
