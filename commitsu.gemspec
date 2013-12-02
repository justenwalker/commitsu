$:.push File.expand_path('../lib', __FILE__)
require 'commitsu/version'

Gem::Specification.new do |s|
  # Metadata
  s.name        = 'commitsu'
  s.version     = Commitsu::VERSION
  s.platform    = Gem::Platform::CURRENT
  s.authors     = ['Justen Walker']
  s.email       = %w(justen.walker@gmail.com)
  #s.licence     = 'MIT'
  s.summary     = 'Commitsu - Stop writing bad commit messages'
  s.description = <<-eos.gsub(/^ +/,'')
                  Commitsu is a tool to facilitate creating better & 
                  more descriptive commit messages for your favorite
                  source control tool
                  eos

  # Manifest
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  
  # Dependencies
  s.required_ruby_version = '>= 1.8.7'
  s.add_dependency     'thor', '~> 0.18.1'
  s.add_dependency     'highline', '~> 1.6.20'
  s.add_dependency     'word_wrapper', '~> 0.5.0'

end
