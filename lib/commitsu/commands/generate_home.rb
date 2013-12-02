require 'fileutils'
module Commitsu
  module Commands
    class GenerateHome < Base
      def run()
        home = environment.home
        skel = environment.find_resource('skel')
        FileUtils.cp_r(skel,home)
      end
    end
  end
end

