# Support for generating documentation using Puppet Strings for each module
# listed in the site directory
class Onceover
  module CodeQuality
    module Docs
      LOCAL_MOD_DIR = "site"

      def self.puppet_strings(html_docs)
        status = true
        format = html_docs ? "html" : "markdown"
        if Dir.exist?(LOCAL_MOD_DIR)
          Dir.glob("#{LOCAL_MOD_DIR}/*/") { |dir|
            Dir.chdir(dir) {
              status &= system("puppet strings generate --format #{format}")
            }
          }
        end

        status
      end

    end
  end
end
