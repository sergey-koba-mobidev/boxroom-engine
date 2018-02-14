$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "boxroom/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "boxroom"
  s.version     = Boxroom::VERSION
  s.authors     = ["Serge Koba"]
  s.email       = ["s.koba@mobidev.biz"]
  s.homepage    = ""
  s.summary     = "File manager engine"
  s.description = "File manager engine"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'rails', '>= 5.0.2'
  s.add_dependency 'dynamic_form'
  s.add_dependency 'acts_as_tree'
  s.add_dependency 'paperclip', '~> 5.2.0'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-fileupload-rails'

  s.add_dependency 'trailblazer-rails', '~> 2.1.0'
  s.add_dependency 'cells-rails', '~> 0.0.8'
  s.add_dependency 'cells-erb', '~> 0.1.0'
  s.add_dependency 'trailblazer-cells', '~> 0.0.3'

  s.add_development_dependency 'sqlite3'
end
