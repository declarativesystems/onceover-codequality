# Support for generating documentation using Puppet Strings for each module
# listed in the site directory
class Onceover
  module CodeQuality
    module Docs
      LOCAL_MOD_DIR = "site"

      def self.puppet_strings(html_docs)
        status = true
        format = html_docs ? "--markup html" : "--format markdown"
        if Dir.exist?(LOCAL_MOD_DIR)
          Dir.glob("#{LOCAL_MOD_DIR}/*/") { |dir|
            Dir.chdir(dir) {
              CodeQuality::Formatter.start_test("Generate documentation in #{dir}")
              # puppet strings prints useful metrics so don't swallow its output
              output, ok = CodeQuality::Executor.run("puppet strings generate #{format}")
              status &= ok
              CodeQuality::Formatter.end_test(output, ok, true)
            }
          }
        end

        status
      end

    end
  end
end
