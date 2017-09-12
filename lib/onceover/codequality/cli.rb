require "onceover/codequality/lint"
require "onceover/codequality/syntax"
class Onceover
  module CodeQuality
    class CLI

        def self.command
          @cmd ||= Cri::Command.define do
            name 'codequality'
            usage 'codequality [--no-lint] [--no-syntax]'
            summary "Code Quality checking for onceover"
            description <<-DESCRIPTION
Check files in your Control Repository for Lint and Syntax errors
            DESCRIPTION
          
            option :l, :no_lint, 'Do not check for lint errors', :argument => :optional
            option :x, :no_syntax, 'Do not check for syntax errors', :argument => :optional

            run do |opts, args, cmd|
              no_lint = opts[:no_lint] || false
              no_syntax = opts[:no_syntax] || false
              status = true
              if ! no_lint
                logger.info "Checking for lint..."
                if ! Onceover::CodeQuality::Lint.puppet
                  status = false
                  logger.error "Lint test failed, see previous errors"
                end
              end

              if ! no_syntax
                logger.info "Checking syntax..."
                if ! Onceover::CodeQuality::Syntax.puppet
                  status = false
                  logger.error "Syntax test failed, see previous errors"
                end
              end

              if status
                logger.info "Code Quality tests passed, have a nice day"
              else
                logger.error "Code Quality tests failed, see previous error"
                exit 1
              end
            end
          end
        end
      end
  end
end

Onceover::CLI::Run.command.add_command(Onceover::CodeQuality::CLI.command)

