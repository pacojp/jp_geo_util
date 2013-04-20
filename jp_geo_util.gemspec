# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jp_geo_util/version"

Gem::Specification.new do |s|
  s.name        = "jp_geo_util"
  s.version     = JpGeoUtil::VERSION
  s.authors     = ["pacojp"]
  s.email       = ["paco.jp@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{japanese geo location convert utility}
  s.description = %q{japanese geo location convert utility}
  s.rubyforge_project = "jp_geo_util"

  #s.add_dependency "batchbase",["0.0.4"]
  #s.add_dependency "net-scp"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
