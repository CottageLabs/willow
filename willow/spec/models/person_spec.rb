require 'rails_helper'

describe Person do
  before do
    class ExampleWork < ActiveFedora::Base
      property :creator, predicate: ::RDF::Vocab::DC.creator, class_name:"Person"
      accepts_nested_attributes_for :creator, reject_if: proc {
       |attributes| (Array(attributes[:first_name]).all?(&:blank?) &&
        Array(attributes[:last_name]).all?(&:blank?)) ||
        Array(attributes[:role]).all?(&:blank?) ||
        Array(attributes[:orcid]).all?(&:blank?)
       }, allow_destroy: true
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates a person active triple resource with an id, first name, last name, orcid and role' do
    @obj = ExampleWork.new
    @obj.attributes = {
      creator_attributes: [
        {
          first_name: 'Foo',
          last_name: 'Bar',
          orcid: '0000-0000-0000-0000',
          role: 'Author'
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.creator.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.creator.first.id).to include('#person')
    expect(@obj.creator.first.first_name).to eq ['Foo']
    expect(@obj.creator.first.last_name).to eq ['Bar']
    expect(@obj.creator.first.orcid).to eq ['0000-0000-0000-0000']
    expect(@obj.creator.first.role).to eq ['Author']
  end

  it 'rejects attributes if first name and last name are blank' do
    @obj = ExampleWork.new
    @obj.attributes = {
      creator_attributes: [
        {
          first_name: 'Foo',
          orcid: '0000-0000-0000-0000',
          role: 'Author'
        },
        {
          last_name: 'Bar',
          orcid: '0000-0000-0000-0000',
          role: 'Author'
        },
        {
          first_name: '',
          last_name: nil,
          orcid: '0000-0000-0000-0000',
          role: 'Author'
        },
        {
          orcid: '0000-0000-0000-0000',
          role: 'Author'
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.creator.size).to eq(2)
  end

  it 'rejects attributes if orcid is blank' do
    @obj = ExampleWork.new
    @obj.attributes = {
      creator_attributes: [
        {
          first_name: 'Foo',
          last_name: 'Bar',
          role: 'Author'
        },
        {
          first_name: 'Foo',
          last_name: 'Bar',
          orcid: '',
          role: 'Author'
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.creator.size).to eq(0)
  end

  it 'rejects attributes if role is blank' do
    @obj = ExampleWork.new
    @obj.attributes = {
      creator_attributes: [
        {
          first_name: 'Foo',
          last_name: 'Bar',
          orcid: '0000-0000-0000-0000'
        },
        {
          first_name: 'Foo',
          last_name: 'Bar',
          orcid: '0000-0000-0000-0000',
          role: nil
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.creator.size).to eq(0)
  end

it 'rejects attributes if all are blank' do
    @obj = ExampleWork.new
    @obj.attributes = {
      creator_attributes: [
        {
          first_name: '',
          last_name: nil,
          role: nil
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.creator.size).to eq(0)
  end

  it 'destroys creator' do
    @obj = ExampleWork.new
    @obj.attributes = {
      creator_attributes: [
        {
          first_name: 'Foo',
          last_name: 'Bar',
          orcid: '0000-0000-0000-0000',
          role: 'Author'
        }
      ]
    }
    @obj.save!
    @obj.reload
    @obj.attributes = {
      creator_attributes: [
        {
          id: @obj.creator.first.id,
          first_name: 'Foo',
          last_name: 'Bar',
          orcid: '0000-0000-0000-0000',
          role: 'Author',
          _destroy: "1"
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.creator.size).to eq(0)
  end
end
