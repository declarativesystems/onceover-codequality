# puppet-syntax does everything we want so we just need a handy way to run
# it and check the result
class Onceover
  module CodeQuality
    module Syntax
      def self.puppet
        status = true
        if File.exist?("Puppetfile")
          status &= system("r10k puppetfile check")
        else
          logger.warn("No Puppetfile found... continuing")
        end

        require 'puppet-syntax/tasks/puppet-syntax'
        begin
          Rake::Task['syntax'].invoke
        rescue SystemExit => e
          logger.error("Invalid syntax")
          status &= e.status
        end
        status
      end
    end
  end
end

