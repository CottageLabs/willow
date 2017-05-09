require 'rails_helper'

describe LicenseStatement do
  before do
    class ExampleWork < ActiveFedora::Base
      property :license, predicate: ::RDF::Vocab::DC.license, class_name:"LicenseStatement"
      accepts_nested_attributes_for :license
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates a license active triple resource with an id, label, definition and webpage' do
    @obj = ExampleWork.new
    @obj.attributes = {
      license_attributes: [
        {
          label: 'A license label',
          definition: 'A definition of the license',
          webpage: 'http://example.com/license'
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.license.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.license.first.id).to include('#license')
    expect(@obj.license.first.label).to eq ['A license label']
    expect(@obj.license.first.definition).to eq ['A definition of the license']
    expect(@obj.license.first.webpage).to eq ['http://example.com/license']
  end
end
