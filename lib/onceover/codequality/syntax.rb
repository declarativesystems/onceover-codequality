require 'open3'
class Onceover
  module CodeQuality
    module Syntax

      def self.puppet
        status = true

        #
        # puppet-syntax
        #

        logger.info("Checking syntax using puppet-syntax rake task...")
        # puppet-syntax seems to assign $stdout/$stderr internally in ways that
        # prevent capturing output. As a nasty hack, run it as inline ruby and
        # capture the output from the process...
        inline_ruby = <<-RUBY_CODE
          require 'puppet-syntax/tasks/puppet-syntax'
          PuppetSyntax.exclude_paths = ['vendor/**/*','spec/templates/*.erb']
          Rake::Task['syntax'].invoke
        RUBY_CODE
        output, s = Open3.capture2e("ruby", "-e", inline_ruby)
        ok = s.exitstatus.zero?
        status &= ok

        if ok
          logger.info("...ok")
        else
          logger.error("puppet-syntax validation failed: #{output}")
        end

        #
        # python yaml
        #

        # Python gives us "better" validation of YAML data then ruby, eg:
        # ```yaml
        #  foo: bar
        # baz: clive
        # ```
        #
        # would parse only the foo key in ruby, throwing away the baz key due to
        # a perceived negative indent, whereas python would tell you to fix the
        # file and make it consistent. This is yaml implementation dependent but
        # users would be advised to fix the file, so lets _also_ validate yaml
        # files with python if available on our path...
        if system("python --version", :err => File::NULL)
          logger.info("Running additional python YAML validation")
          script = File.join(File.dirname(File.expand_path(__FILE__)), "../../../res/validate_yaml.py")
          output, s = Open3.capture2e("python #{script}")
          ok = s.exitstatus.zero?
          status &= ok

          if ok
            logger.info("...ok")
          else
            logger.error("Puppetfile validation failed: #{output}")
          end
        else
          logger.warn("Please install python and add it to your path for enhanced YAML validation")
        end

        status
      end
    end
  end
end

