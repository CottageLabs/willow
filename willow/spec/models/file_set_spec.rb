require 'spec_helper'

RSpec.describe FileSet do
  it "has a file_uuid" do
    expect(described_class.new.respond_to?(:file_uuid)).to be_truthy
  end

  it "has a checksum_uuid" do
    expect(described_class.new.respond_to?(:checksum_uuid)).to be_truthy
  end
end
