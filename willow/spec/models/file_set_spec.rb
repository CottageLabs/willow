require 'rails_helper'

RSpec.describe FileSet do
  it "has a file_uuid" do
    expect(described_class.new.file_uuid).to must_be_nil
  end
end
