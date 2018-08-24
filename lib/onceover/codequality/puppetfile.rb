# Support for checking syntax of Puppetfile
class Onceover
  module CodeQuality
    module Puppetfile

      def self.puppetfile
        if File.exists? "Puppetfile"
          status = system("bundle exec r10k puppetfile check")
        else
          puts "No Puppetfile found!"
          status = false
        end

        status
      end

    end
  end
end


