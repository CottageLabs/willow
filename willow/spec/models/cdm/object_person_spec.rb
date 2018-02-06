require 'rails_helper'

RSpec.describe Cdm::ObjectPerson do
  describe 'given name' do
    let(:roles) { %w(author reviewer) }
    let(:roles_attributes) {[{role_type: 'author'}, {role_type: 'reviewer'}]}
    let(:given_name) { 'Paul' }
    let(:honorific_prefix) {'Lord'}
    let(:family_name) { 'MaK' }
    let(:build_attributes) { {honorific_prefix: honorific_prefix, given_name: given_name, family_name: family_name, object_person_roles_attributes: roles_attributes}}
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

    it 'has multiple roles' do
      expect(built_object.object_person_roles).to be_kind_of ActiveFedora::Associations::CollectionProxy
      expect(built_object.object_person_roles.to_a.map(&:role_type)).to eq roles
    end

    it 'requires either given or family name' do
      obj=build(:cdm_object_person, build_attributes.delete([:given_name, :family_name]))
      expect(obj.errors)
    end
  end

end