require 'rails_helper'

RSpec.describe OrganisationStatement, :vcr do
  before do
    class ExampleWork < ActiveFedora::Base
      property :organisation_nested, predicate: ::RDF::Vocab::ORG.organization, class_name:"OrganisationStatement"
      accepts_nested_attributes_for :organisation_nested
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates an organisation active triple resource with an id and all properties' do
    @obj = ExampleWork.new
    @obj.attributes = {
      organisation_nested_attributes: [
        {
          name: 'Foo Bar',
          role: 'Funder',
          identifier: '1234567',
          uri: 'http://localhost/organisation/1234567'
        }
      ]
    }
    expect(@obj.organisation_nested.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.organisation_nested.first.name).to eq ['Foo Bar']
    expect(@obj.organisation_nested.first.role).to eq ['Funder']
    expect(@obj.organisation_nested.first.identifier).to eq ['1234567']
    expect(@obj.organisation_nested.first.uri).to eq ['http://localhost/organisation/1234567']
  end

  it 'has the correct uri' do
    @obj = ExampleWork.new
    @obj.attributes = {
      organisation_nested_attributes: [
        {
          name: 'Foo Bar',
          role: 'Funder',
          identifier: '1234567',
          uri: 'http://localhost/organisation/1234567'
        }
      ]
    }
    expect(@obj.organisation_nested.first.id).to include('#organisation')
  end
end
