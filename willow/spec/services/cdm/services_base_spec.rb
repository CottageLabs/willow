require 'rails_helper'

describe Cdm::ServicesBase do
  describe "#select_all_options" do
    it "raises an exception when not overridden" do
      expect {described_class.select_all_options}.to raise_exception(RuntimeError, 'Must override authority name in derived classes')
    end
  end
end
