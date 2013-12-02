module Commitsu
  class Trackers
    def self.get(name,environment)
      require "commitsu/tracker/#{name}"
      cls_name = name.split('_').map { |h| h.capitalize }.join('')
      cls = Object.const_get('Commitsu').const_get('Tracker').const_get(cls_name)
      cls.new(environment)
    end
    def self.none
      self.get('none',nil)
    end
  end
end
