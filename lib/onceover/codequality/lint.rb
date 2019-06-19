class Onceover
  module CodeQuality
    module Lint

      # Apply linting to the manifests directory and each module under `site`
      LINT_PATHS = [
        "manifests",
      ]

      # use our default options unless user has created own settings
      if ! File.exist? ".puppet-lint.rc"
        LINT_OPTIONS = [
          "--relative",
          "--fail-on-warnings",
          "--no-double_quoted_strings-check",
          "--no-80chars-check",
          "--no-variable_scope-check",
          "--no-quoted_booleans-check",
        ].freeze
      else
        LINT_OPTIONS = [].freeze
      end

      def self.puppet
        status = true

        # wait until runtime to scan directories for unit tests
        lint_paths = LINT_PATHS.concat(
          CodeQuality::Environment.get_site_dirs.each { |site_dir|
            Dir.glob("#{site_dir}/*").select { |f| File.directory? f}
          }
        )
        lint_paths.each { |p|
          if Dir.exist?(p)
            CodeQuality::Formatter.start_test("lint in #{p}")
            output, ok = CodeQuality::Executor.run("puppet-lint #{LINT_OPTIONS.join ' '} #{p}")
            status &= ok
            CodeQuality::Formatter.end_test(output, ok)
          end
        }

        status
      end
    end
  end
end
