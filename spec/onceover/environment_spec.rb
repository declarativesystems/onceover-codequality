require "spec_helper"
require "onceover/cli"
require "onceover/codequality"
require "onceover/codequality/environment"

RSpec.describe Onceover::CodeQuality::Environment do
  # puppet strings will only give bad status if the executable is broken so no test

  it "Detects site" do
    Dir.chdir "spec/testcase/environment/site" do
      expect(Onceover::CodeQuality::Environment.get_site_dirs()[0]).to eq "site"
    end
  end

  it "Detects site-modules" do
    Dir.chdir "spec/testcase/environment/site_modules" do
      expect(Onceover::CodeQuality::Environment.get_site_dirs()[0]).to eq "site-modules"
    end
  end

  it "Detects multiple directories" do
    Dir.chdir "spec/testcase/environment/multi_modules" do
      site_dirs = Onceover::CodeQuality::Environment.get_site_dirs()
      expect(site_dirs[0]).to eq "site-modules"
      expect(site_dirs[1]).to eq "more-modules"
      expect(site_dirs.size).to be 2
    end
  end

  it "Drops path elements that are not allowed" do
    Dir.chdir "spec/testcase/environment/complex" do
      site_dirs = Onceover::CodeQuality::Environment.get_site_dirs()
      expect(site_dirs[0]).to eq "site-modules"
      expect(site_dirs.size).to be 1
    end
  end

  it "raises on missing environment.conf" do
    expect { Onceover::CodeQuality::Environment.get_site_dirs() }.to raise_error /Missing environment/
  end

  it "raises on malformed environment.conf" do
    Dir.chdir "spec/testcase/environment/malformed" do
      expect { Onceover::CodeQuality::Environment.get_site_dirs() }.to raise_error /Malformed environment/
    end
  end
end
