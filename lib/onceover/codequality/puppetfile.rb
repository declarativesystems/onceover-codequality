# Support for checking syntax of Puppetfile
class Onceover
  module CodeQuality
    module Puppetfile
      def self.puppetfile
        status = true
        if File.exist?("Puppetfile")
          CodeQuality::Formatter.start_test("Puppetfile")
          output, ok = CodeQuality::Executor.run("r10k puppetfile check")

          status &= ok

          CodeQuality::Formatter.end_test(output, ok)
        else
          logger.warn("No Puppetfile found... continuing")
        end

        status
      end
    end
  end
end
