require 'rubygems'
require 'bundler/setup'

Bundler.require :default

require 'rspec/core/rake_task'

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
rescue LoadError
end

require 'bundler/gem_tasks'

RSpec::Core::RakeTask.new('spec')

begin
  require 'ci/reporter/rake/rspec'
  require 'ci/reporter/rake/cucumber'
  task :features => ['ci:setup:cucumber']
  task :spec  => ['ci:setup:rspec']
rescue LoadError
end

task :test => [:spec,:features]

task :default do
  sh %{rake -T}
end
