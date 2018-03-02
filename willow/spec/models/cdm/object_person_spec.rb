require 'rails_helper'

RSpec.describe Cdm::ObjectPerson do
  describe 'given name' do
    let(:roles) { %w(author reviewer) }
    let(:roles_attributes) { roles.map { |x| {role_type: x } } }
    let(:honorific_prefix) { 'Mr.' }
    let(:given_name) { 'Raymond' }
    let(:family_name) { 'Luxury - Ya Ch t' }
    let(:mail) { 'my@email.com'}
    let(:build_attributes) {
      {
        honorific_prefix: honorific_prefix,
        given_name: given_name,
        family_name: family_name,
        mail: mail,
        object_person_roles_attributes: roles_attributes
      }
    }
    let(:built_object) { build(:cdm_object_person, build_attributes) }

    it 'has a single honorific prefix' do
      expect(built_object.honorific_prefix).to be_kind_of String
      expect(built_object.honorific_prefix).to eq honorific_prefix
    end

    it 'has a single given name' do
      expect(built_object.given_name).to be_kind_of String
      expect(built_object.given_name).to eq given_name
    end

    it 'has a single family name' do
      expect(built_object.family_name).to be_kind_of String
      expect(built_object.family_name).to eq family_name
    end

    it 'has a single email' do
      expect(built_object.mail).to be_kind_of String
      expect(built_object.mail).to eq mail
    end

    it 'has multiple roles' do
      expect(built_object.object_person_roles).to be_kind_of ActiveFedora::Associations::CollectionProxy
      expect(built_object.object_person_roles.to_a.map(&:role_type)).to eq roles
    end

    it 'requires either given or family name' do
      obj=build(:cdm_object_person, build_attributes.except(:given_name, :family_name))
      expect(obj.valid?).to be_falsey
      expect(obj.errors.messages[:given_name]).to include('a minimum of given or family name')
    end

    it 'should be valid with all attributes present' do
      expect(built_object.valid?).to be_truthy
    end
  end
end
