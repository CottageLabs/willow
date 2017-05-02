require 'rails_helper'

describe LicenseStatement do
  before do
    class ExampleWork < ActiveFedora::Base
      property :license, predicate: ::RDF::Vocab::DC.license, class_name:"LicenseStatement"
      accepts_nested_attributes_for :license, reject_if: :all_blank, allow_destroy: true
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

  it 'rejects attributes if all blank' do
    @obj = ExampleWork.new
    @obj.attributes = {
      license_attributes: [
        {
          label: 'Test label'
        },
        {
          label: '',
          definition: nil,
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.license.size).to eq(1)
  end

  it 'destroys license' do
    @obj = ExampleWork.new
    @obj.attributes = {
      license_attributes: [
        {
          label: 'test label'
        }
      ]
    }
    @obj.save!
    @obj.reload
    @obj.attributes = {
      license_attributes: [
        {
          id: @obj.license.first.id,
          label: 'test label',
          _destroy: "1"
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.license.size).to eq(0)
  end
end
