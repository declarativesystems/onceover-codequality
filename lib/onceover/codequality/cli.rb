require "onceover/codequality/lint"
require "onceover/codequality/syntax"
require "onceover/codequality/docs"
require "onceover/codequality/puppetfile"
class Onceover
  module CodeQuality
    class CLI

        def self.command
          @cmd ||= Cri::Command.define do
            name 'codequality'
            usage 'codequality [--no-syntax] [--no-lint] [--no-docs] [--html-docs] [--no-puppetfile]'
            summary "Code Quality checking for onceover"
            description <<-DESCRIPTION
              Check files in your Control Repository for Lint and Syntax errors
            DESCRIPTION
          
            option :no_lint, 'Do not check for lint errors', :argument => :optional
            option :no_puppetfile, 'Do not check Puppetfile for syntax errors', :argument => :optional
            option :no_syntax, 'Do not check for syntax errors', :argument => :optional
            option :no_docs, 'Do not generate documentation (puppet-strings) for local modules', :argument => :optional
            option :html_docs, 'Generate docs in HTML format instead of markdown', :argument => :optional

            run do |opts, args, cmd|
              no_lint = opts[:no_lint] || false
              no_syntax = opts[:no_syntax] || false
              no_docs = opts[:no_docs] || false
              no_puppetfile = opts[:no_puppetfile] || false
              html_docs = opts[:html_docs] || false
              status = true

              if ! no_syntax
                logger.info "Checking syntax..."
                if ! Onceover::CodeQuality::Syntax.puppet
                  status = false
                  logger.error "Syntax test failed, see previous errors"
                end
              end

              if ! no_lint
                logger.info "Checking for lint..."
                if ! Onceover::CodeQuality::Lint.puppet
                  status = false
                  logger.error "Lint test failed, see previous errors"
                end
              end

              if ! no_puppetfile
                logger.info "Checking Puppetfile"
                if ! Onceover::CodeQuality::Puppetfile.puppetfile
                  status = false
                  logger.error "puppetfile syntax failed, see previous errors"
                end
              end

              if ! no_docs
                logger.info "Generating documentation..."
                if ! Onceover::CodeQuality::Docs.puppet_strings(html_docs)
                  status = false
                  logger.error "Documentation generation failed, see previous errors"
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

