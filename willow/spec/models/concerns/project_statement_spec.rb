require 'rails_helper'
require "./lib/vocabularies/rioxxterms"
describe ProjectStatement do
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
          funder_name: 'A name for the funder',
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.project.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.project.first.id).to include('#project')
    expect(@obj.project.first.identifier).to eq ['20170102']
    expect(@obj.project.first.funder_name).to eq ['A name for the funder']
  end
end
