class Onceover
  module CodeQuality
    module Environment
      ENVIRONMENT_CONF = "environment.conf"

      # Latest best practice is to change the name of `site` to be
      # `site-modules`. This means we need to start processing `environment.conf`
      # to extract this...
      def self.get_site_dirs()
        if File.exist?(ENVIRONMENT_CONF)
          # modulepath = site-modules:modules:$basemodulepath
          modulepath = open(ENVIRONMENT_CONF) { |f| f.each_line.find { |line| line.include?("modulepath") } }

          begin
            environments = modulepath.split("=")[1].split(":").reject { |e|
              # reject any elements containing interpolation or referencing modules
              # loaded by r10k
              e =~ /\$/ || e == "modules" || e =~ /[\\.\/]/
            }.map { |e|
              e.strip
            }
          rescue NoMethodError => e
            raise "Malformed environment configuration: #{ENVIRONMENT_CONF}"
          end
        else
          raise "Missing environment configuration: #{ENVIRONMENT_CONF}"
        end

        environments
      end
    end
  end
end
