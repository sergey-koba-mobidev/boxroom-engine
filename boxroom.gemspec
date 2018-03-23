$:.push File.expand_path('../lib', __FILE__)

require 'boxroom/version'

Gem::Specification.new do |s|
  s.name        = 'boxroom'
  s.version     = Boxroom::VERSION
  s.authors     = ['Serge Koba']
  s.email       = ['s.koba@mobidev.biz']
  s.homepage    = 'https://github.com/sergey-koba-mobidev/boxroom-engine'
  s.summary     = 'Rails file manager engine'
  s.description = 'Rails file manager engine'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 2.3.1'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.0'
  s.add_dependency 'dynamic_form', '~> 1.1'
  s.add_dependency 'acts_as_tree', '~> 2.7'
  s.add_dependency 'paperclip', '~> 5.2.0'
  s.add_dependency 'bulma-rails', '~> 0.6.2'
  s.add_dependency 'font-awesome-rails', '~> 4.7'
  s.add_dependency 'jquery-rails', '~> 4.3'
  s.add_dependency 'jquery-fileupload-rails', '~> 0.4.7'

  s.add_dependency 'trailblazer-rails', '~> 2.1.0'
  s.add_dependency 'cells-rails', '~> 0.0.8'
  s.add_dependency 'cells-erb', '~> 0.1.0'
  s.add_dependency 'trailblazer-cells', '~> 0.0.3'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'database_cleaner'
end
