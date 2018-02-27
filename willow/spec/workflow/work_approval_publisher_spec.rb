require 'rails_helper'

RSpec.describe Rdss::Messaging::Workflow::WorkApprovalPublisher do
  let(:rdss_cdm) { create(:rdss_cdm) }

  describe "A work reaching the approval stage" do
    it 'broadcasts a work approval' do
      expect { described_class.(target: rdss_cdm) }.to broadcast(:work_approval)
    end
  end

end
