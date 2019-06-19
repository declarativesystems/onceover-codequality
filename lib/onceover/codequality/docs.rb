# Support for generating documentation using Puppet Strings for each module
# listed in the environment.conf modulepath
class Onceover
  module CodeQuality
    module Docs

      def self.puppet_strings(html_docs)
        status = true
        format = html_docs ? "--markup html" : "--format markdown"

        CodeQuality::Environment.get_site_dirs.each { |local_mod_dir|
          if Dir.exist?(local_mod_dir)
            Dir.glob("#{local_mod_dir}/*/") { |dir|
              Dir.chdir(dir) {
                CodeQuality::Formatter.start_test("Generate documentation in #{dir}")
                # puppet strings prints useful metrics so don't swallow its output
                output, ok = CodeQuality::Executor.run("puppet strings generate #{format}")
                status &= ok
                CodeQuality::Formatter.end_test(output, ok, true)
              }
            }
          end
        }

        status
      end

    end
  end
end
