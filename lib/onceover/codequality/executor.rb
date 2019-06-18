class Onceover
  module CodeQuality
    module Executor

      # Capture all program output and check the exit status was zero
      def self.run(*command)
        output, s = Open3.capture2e(*command)
        ok = s.exitstatus.zero?

        return output, ok
      end
    end
  end
end
