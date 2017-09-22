# Support for generating documentation using Puppet Strings for each module
# listed in the site directory
class Onceover
  module CodeQuality
    module Docs
      LOCAL_MOD_DIR = "site"

      def self.puppet_strings
        status = true
        if Dir.exist?(LOCAL_MOD_DIR)
          Dir.glob("#{LOCAL_MOD_DIR}/*/") { |dir|
            Dir.chdir(dir) {
              status &= system("puppet strings")
            }
          }
        end

        status
      end

    end
  end
end
