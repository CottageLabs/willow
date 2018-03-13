require 'spec_helper'
class DummyAccesses
  attr_reader :access_statement, :access_type
  def initialize(access_type: access_type, access_statement: access_statement)
    @access_type=access_type
    @access_statement=access_statement
  end
end


class Dummy
  def accesses
    [
      DummyAccesses.new(access_type: 'open', access_statement: nil),
      DummyAccesses.new(access_type: 'controlled', access_statement: 'wibble')
    ]
  end
end


RSpec.describe ::Cdm::Messaging::Access do
  describe 'decodes messaging sections' do
    let(:access_map) { { access: [{ accessType: nil, accessStatement: nil}] } }
    let(:test_object) { Dummy.new }
    let(:decoded_class) { described_class.('test', access_map, test_object) }
    let(:access_result) { { access: [
      {
        accessType: 1,
        accessStatement: 'Open'
      },
      {
        accessType: 3,
        accessStatement: 'wibble'
      }
    ]}}

    it 'should have methods for the elements in the passed section' do
      expect(decoded_class[:test]).to eql(access_result)
    end
  end
end