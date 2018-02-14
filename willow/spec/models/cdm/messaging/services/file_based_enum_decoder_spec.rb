require 'rails_helper'

RSpec.describe Cdm::Messaging::Services::FileBasedEnumDecoder do
  describe 'caches messaging file sections' do
    expect { Cdm::Messaging::Services::FileBasedEnumDecoder.new }.to raise 'Singleton'
  end
end