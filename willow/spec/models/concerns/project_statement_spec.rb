require 'rails_helper'
require "./lib/vocabularies/rioxxterms"

RSpec.describe ProjectStatement, :vcr do
  before do
    class ExampleWork < ActiveFedora::Base
      property :project, predicate: RioxxTerms.project, class_name:"ProjectStatement"
      accepts_nested_attributes_for :project
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates a date active triple resource with an date and description' do
    @obj = ExampleWork.new
    @obj.attributes = {
      project_attributes: [
        {
          identifier: '20170102',
          title: 'A test project',
          funder_name: 'A name for the funder',
          funder_id: '1111111',
          grant_number: 'a3rf344'
        }
      ]
    }
    expect(@obj.project.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.project.first.identifier).to eq ['20170102']
    expect(@obj.project.first.title).to eq ['A test project']
    expect(@obj.project.first.funder_name).to eq ['A name for the funder']
    expect(@obj.project.first.funder_id).to eq ['1111111']
    expect(@obj.project.first.grant_number).to eq ['a3rf344']
  end

  it 'has the correct uri' do
    @obj = ExampleWork.new
    @obj.attributes = {
      project_attributes: [
        {
          identifier: '20170102',
          title: 'A test project',
          funder_name: 'A name for the funder',
          funder_id: '1111111',
          grant_number: 'a3rf344'
        }
      ]
    }
    expect(@obj.project.first.id).to include('#project')
  end
end
