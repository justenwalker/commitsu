# Credits to Joe Corcoran
# http://blog.joecorcoran.co.uk/2013/09/04/simple-pattern-ruby-dsl/

require 'delegate'

module Commitsu
  module DSL
    def build(*args, &block)
      base = self.new(*args)
      delegator_klass = self.const_get('DSLDelegator')
      delegator = delegator_klass.new(base)
      delegator.instance_eval(&block)
      base
    end

    def from_file(path,*args)
      base = self.new(*args)
      delegator_klass = self.const_get('DSLDelegator')
      delegator = delegator_klass.new(base)
      delegator.instance_eval {
        eval(path.read,binding,path.to_path,1)
      }
      base
    end

    def dsl(&block)
      delegator_klass = Class.new(SimpleDelegator, &block)
      self.const_set('DSLDelegator', delegator_klass)
    end
  end
end