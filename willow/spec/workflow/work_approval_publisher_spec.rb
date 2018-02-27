require 'rails_helper'

RSpec.describe Rdss::Messaging::Workflow::WorkApprovalPublisher do

  describe "A work reaching the approval stage" do
    it 'broadcasts a work approval' do
      expect { described_class.("") }.to broadcast(:work_approval)
    end
  end

end
