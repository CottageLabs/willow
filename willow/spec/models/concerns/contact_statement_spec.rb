require 'rails_helper'

RSpec.describe ContactStatement, :vcr do
  before do
    class ExampleWork < ActiveFedora::Base
      property :contact, predicate: ::RDF::Vocab::DCAT.contactPoint, class_name:"ContactStatement"
      accepts_nested_attributes_for :contact
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates a contact active triple resource with a name, email, address and telephone' do
    @obj = ExampleWork.new
    @obj.attributes = {
      contact_attributes: [{
          label: 'Home',
          email: 'joe.blogg@example.com',
          address: '123 Street, City, State, Country',
          telephone: '123 456 7890'
        }]
    }
    expect(@obj.contact.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.contact.first.label).to eq ['Home']
    expect(@obj.contact.first.email).to eq ['joe.blogg@example.com']
    expect(@obj.contact.first.address).to eq ['123 Street, City, State, Country']
    expect(@obj.contact.first.telephone).to eq ['123 456 7890']
  end

  it 'has the correct uri' do
    @obj = ExampleWork.new
    @obj.attributes = {
      contact_attributes: [{
          label: 'Home',
          email: 'joe.blogg@example.com',
          address: '123 Street, City, State, Country',
          telephone: '123 456 7890'
        }]
    }
    expect(@obj.contact.first.id).to include('#contact')
  end
end
