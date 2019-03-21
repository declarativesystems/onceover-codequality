# Support for generating documentation using Puppet Strings for each module
# listed in the site directory
class Onceover
  module CodeQuality
    module Docs
      LOCAL_MOD_DIR = "site"

      def self.puppet_strings(html_docs)
        logger.info "Generating documentation..."
        status = true
        format = html_docs ? "html" : "markdown"
        if Dir.exist?(LOCAL_MOD_DIR)
          Dir.glob("#{LOCAL_MOD_DIR}/*/") { |dir|
            Dir.chdir(dir) {
              # puppet strings prints useful metrics so don't swallow its output
              s = system("puppet strings generate --format #{format}")
              if ! s
                logger.error("Error running puppet strings - see previous output")
              end
              status &= s
            }
          }
        end

        status
      end

    end
  end
end
