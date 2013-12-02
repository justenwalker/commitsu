module Commitsu
  class Issue
    attr_reader :name,:summary,:id,:url
    def initialize(hash)
      hash.each_pair do |k,v|
        if [:name,:summary,:id,:url].include?(k)
          instance_variable_set("@#{k}",v)
        end
      end
    end
  end
end
