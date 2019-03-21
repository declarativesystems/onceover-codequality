# Support for checking syntax of Puppetfile
class Onceover
  module CodeQuality
    module Puppetfile

      def self.puppetfile
        status = true
        if File.exist?("Puppetfile")
          logger.info("Checking Puppetfile...")
          output, s = Open3.capture2e("r10k puppetfile check")
          ok = s.exitstatus.zero?
          status &= ok

          if ok
            logger.info("...ok")
          else
            logger.error("Puppetfile validation failed: #{output}")
          end
        else
          logger.warn("No Puppetfile found... continuing")
        end

        status
      end

    end
  end
end


