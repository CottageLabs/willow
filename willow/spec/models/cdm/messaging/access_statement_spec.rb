# require 'spec_helper'
# class Dummy
#   attr_reader :access_statement, :access_type
#
#   def initialize(access_statement: nil)
#     @access_statement=access_statement
#     @access_type='open'
#   end
# end
#
# RSpec.describe ::Cdm::Messaging::AccessStatement do
#   describe 'decodes messaging sections' do
#     let(:access_statement_map) { { accessStatement: nil} }
#
#     it 'should have methods for the elements in the passed section' do
#       expect(described_class.('test', access_statement_map, Dummy.new(access_statement: 'passed in statement'))[:test]).to eql(accessStatement: 'passed in statement')
#       expect(described_class.('test', access_statement_map, Dummy.new)[:test]).to eql(accessStatement: 'Open')
#     end
#   end
# end