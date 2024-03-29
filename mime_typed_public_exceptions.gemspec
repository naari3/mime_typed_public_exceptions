# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'mime_typed_public_exceptions'
  s.version     = '0.3.0'
  s.authors     = ['naari3']
  s.email       = ['naari.named@gmail.com']
  s.homepage    = 'https://github.com/naari3/mime_typed_public_exceptions'
  s.summary     = 'PublicExceptions for multiple mime types'
  s.description = s.summary
  s.license     = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md'
  ]

  s.add_dependency 'mimemagic'
  s.add_dependency 'rails', '>= 5'

  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rspec_junit_formatter'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'sqlite3'
end
