class Onceover
  module CodeQuality
    module Lint

      # Apply linting to the manifests directory and each module under `site` 
      LINT_PATHS = [
        "manifests",
      ].concat(Dir.glob('site/*').select {|f| File.directory? f})

      LINT_OPTIONS = [
        "--relative",
        "--fail-on-warnings",
        "--no-double_quoted_strings-check",
        "--no-80chars-check",
        "--no-variable_scope-check",
        "--no-quoted_booleans-check",
      ]

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
