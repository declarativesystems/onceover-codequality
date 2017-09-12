# puppet-syntax does everything we want so we just need a handy way to run
# it and check the result
class Onceover
  module CodeQuality
    module Syntax
      def self.puppet
        # rake task contains an exit statement so run it in a subshell to
        # capture and continue
        status = system(
"ruby << EOD
    require 'puppet-syntax/tasks/puppet-syntax'
    Rake::Task['syntax'].invoke
EOD")
        status
      end
    end
  end
end

