require "spec_helper"
require "onceover/cli"
require "onceover/codequality"
require "onceover/codequality/lint"

RSpec.describe Onceover::CodeQuality::Lint do
  it "Detects lint errors" do
    Dir.chdir "spec/testcase/bad_lint" do
      # capture logger output to check debug messages are output on failure
      capture_stringio = StringIO.new
      $logger = Logging.logger(capture_stringio)

      expect(Onceover::CodeQuality::Lint.puppet).to be false

      $logger = nil
      expect(capture_stringio.string).to match /WARNING:/
    end
  end

  it "Detects lint OK" do
    Dir.chdir "spec/testcase/good_lint" do
      expect(Onceover::CodeQuality::Lint.puppet).to be true
    end
  end
end
