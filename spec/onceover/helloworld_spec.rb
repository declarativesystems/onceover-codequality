require "spec_helper"

RSpec.describe Onceover::Helloworld do
  it "has a version number" do
    expect(Onceover::Helloworld::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
