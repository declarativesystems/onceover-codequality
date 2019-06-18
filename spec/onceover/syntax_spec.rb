require "spec_helper"
require "onceover/cli"
require "onceover/codequality"
require "onceover/codequality/syntax"
require "logging"


RSpec.describe Onceover::CodeQuality::Syntax do
  it "Detects syntax errors" do
    Dir.chdir "spec/testcase/bad_syntax" do

      # capture logger output to check debug messages are output on failure
      capture_stringio = StringIO.new
      $logger = Logging.logger(capture_stringio)
      expect(Onceover::CodeQuality::Syntax.puppet).to be false

      $logger = nil
      expect(capture_stringio.string).to match /Syntax error/
    end
  end

  it "Detects syntax OK" do
    Dir.chdir "spec/testcase/good_syntax" do
      expect(Onceover::CodeQuality::Syntax.puppet).to be true
    end
  end
end