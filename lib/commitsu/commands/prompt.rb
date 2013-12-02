module Commitsu
  module Commands
    class Prompt < Base
      def run(filename,message)
        environment.new_message(message).render(filename)
      end
    end
  end
end

