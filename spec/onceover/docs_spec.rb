require "spec_helper"
require "onceover/cli"
require "onceover/codequality"
require "onceover/codequality/docs"

RSpec.describe Onceover::CodeQuality::Docs do
  # puppet strings will only give bad status if the executable is broken so no test

  it "Detects docs generate OK" do
    Dir.chdir "spec/testcase/good_docs" do
      expect(Onceover::CodeQuality::Docs.puppet_strings(false)).to be true
    end
  end

  it "Works in HTML mode" do
    Dir.chdir "spec/testcase/good_docs" do
      expect(Onceover::CodeQuality::Docs.puppet_strings(true)).to be true
    end
  end
end
