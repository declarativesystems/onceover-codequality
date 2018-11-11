class Onceover
  module CodeQuality
    module Lint

      # Apply linting to the manifests directory and each module under `site` 
      LINT_PATHS = [
        "manifests",
      ].concat(Dir.glob('site/*').select {|f| File.directory? f})

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
        LINT_PATHS.each { |p|
          if Dir.exists?(p)
            Dir.chdir(p) do
              logger.info("checking #{p}")
              if ! system("puppet-lint #{LINT_OPTIONS.join ' '} . ")
                status = false
              end
            end
          end
        }

        status
      end
    end
  end
end
