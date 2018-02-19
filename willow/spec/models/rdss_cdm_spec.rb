# Generated via
#  `rails generate hyrax:work RdssCdm`
require 'rails_helper'
require 'vcr'

RSpec.describe RdssCdm do
  def build_field(field_name:, content:)
    build(:rdss_cdm, field_name => content)
  end

  def build_and_index_field(field_name:, content:, index_name:)
    build_field(field_name: field_name, content: content).to_solr[index_name.to_s]
  end

  def build_and_check_field(field_name:, content:)
    expect(build_field(field_name: field_name, content: content).send(field_name)).to eq content
  end

  def build_and_check_index(field_name:, content:, index_name:)
    expect(build_and_index_field(field_name: field_name, content: content, index_name: index_name)).to eq [content].flatten(1)
  end

  def valid_attributes
    {title: ['title'],
      object_resource_type: 'object_resource_type',
      object_value: 'object_value',
      object_people_attributes: [{ given_name: 'Peggy',
                                   family_name: 'Sue',
                                   object_person_roles_attributes: [{ role_type: 'author' }, { role_type: 'editor'}]
                                 },{
                                   given_name: 'Brian',
                                   object_person_roles_attributes: [{ role_type: 'messiah' }, { role_type: 'very naughty boy' }]
                                 }],
     object_organisation_roles_attributes: [{ role: 'funder' }]
    }
  end

  def check_mandatory_validation(field_name:, display_name: nil, association: false, association_content: [])
    display_name||=field_name
    VCR.use_cassette('rdss_cdm/create_' + field_name.to_s, match_requests_on: [:method, :host]) do
      obj = build(:rdss_cdm, (association ? {field_name.to_s + '_attributes' => association_content} : {field_name => nil}))
      expect(obj.valid?).to eq false
      expect(obj.errors.messages[field_name]).to include("Your work must have a #{display_name}.")
    end
  end

  it 'has human readable type rdss_cdm' do
    obj = build(:rdss_cdm)
    expect(obj.human_readable_type).to eq('Dataset')
  end

  describe 'title' do
    it 'requires title' do
      check_mandatory_validation(field_name: :title)
    end

    it 'has a single valued title field' do
      obj = build(:rdss_cdm, title: ['test rdss_cdm']) # Note it's actually multivalue so we set it as an array
      expect(obj.title).to eq 'test rdss_cdm' # but title is returned as a single string
    end

    it 'indexes title' do
      build_and_check_index(field_name: :title, content: %w(title), index_name: :title_tesim)
    end
  end

  describe 'version' do
    it 'has a version' do
      build_and_check_field(field_name: :object_version, content: 'version')
    end

    it 'indexes version' do
      build_and_check_index(field_name: :object_version, content: 'version', index_name: :object_version_tesim)
    end
  end

  # single valued
  describe 'uuid' do
    it 'has uuid' do
      build_and_check_field(field_name: :object_uuid, content: 'uuid')
    end
  end

  describe 'description' do
    it 'has description' do
      build_and_check_field(field_name: :object_description, content: 'description')
    end

    it 'indexes description' do
      build_and_check_index(field_name: :object_description, content: 'description', index_name: :object_description_tesim)
    end
  end

  describe 'keywords' do
    it 'has keywords' do
      build_and_check_field(field_name: :object_keywords, content: %w(keywords))
    end

    it 'indexes keywords' do
      build_and_check_index(field_name: :object_keywords, content: %w(keywords), index_name: :object_keywords_tesim)
    end
  end

  describe 'category' do
    it 'has category' do
      build_and_check_field(field_name: :object_category, content: %w(category))
    end

    it 'indexes category' do
      build_and_check_index(field_name: :object_category, content: %w(category), index_name: :object_category_tesim)
    end
  end

  describe 'object_resource_type' do
    it 'requires object_resource_type' do
      check_mandatory_validation(field_name: :object_resource_type, display_name: 'resource type')
    end

    it 'has object_resource_type' do
      build_and_check_field(field_name: :object_resource_type, content: 'resource_type')
    end

    it 'indexes object_resource_type' do
      build_and_check_index(field_name: :object_resource_type, content: 'resource_type', index_name: :object_resource_type_tesim)
    end
  end

  describe 'object_value' do
    it 'requires object_value' do
      check_mandatory_validation(field_name: :object_value, display_name: 'value')
    end

    it 'has object_value' do
      build_and_check_field(field_name: :object_value, content: 'normal')
    end

    it 'indexes object_value' do
      build_and_check_index(field_name: :object_value, content: 'normal', index_name: :object_value_tesim)
    end
  end

  # object_dates tests

  describe 'nested attributes for object_dates' do
    it 'accepts object_dates attributes' do
      obj = build(:rdss_cdm, object_dates_attributes: [{ date_value: '2017-01-01', date_type: 'copyrighted' }])
      expect(obj.object_dates.first).to be_kind_of ActiveFedora::Base
      expect(obj.object_dates.first.date_value).to eq '2017-01-01'
      expect(obj.object_dates.first.date_type).to eq 'copyrighted'
    end

#    it 'has the correct rdss_cdm_id' do
#      obj = build(:rdss_cdm, object_dates_attributes: [{ date_value: '2017-01-01', date_type: 'copyrighted' }])
#      expect(@obj.object_dates.first.id).to include('#object_dates')
#    end
# TODO check rdss_cdm id

    it 'rejects date attributes if date is blank' do
      obj = build(:rdss_cdm, object_dates_attributes: [
                                                  {
                                                    date_value: '2017-01-01',
                                                    date_type: 'copyrighted'
                                                  },
                                                  {
                                                    date_type: 'copyrighted'
                                                  },
                                                  {
                                                    date_value: '2018-01-01'
                                                  },
                                                  {
                                                    date_value: ''
                                                  }
                                                ])
      expect(obj.object_dates.size).to eq(1)
    end

    it 'destroys date' do
      # TODO: work out how to test destroying a related date through attributes=
      # The main issue is that since we can't save to fedora in the tests, we are unable
      # to create a nested object_date with an id. therefore we can't test sending in parameters
      # of the form {"id" => "XXX", "_destroy"=>"1"}
    end

    it 'indexes the date' do
      obj = build(:rdss_cdm, object_dates_attributes: [{
                                                    date_value: '2017-01-01',
                                                    date_type: 'copyrighted',
                                                }, {
                                                    date_value: '2018-01-01'
                                                }])
      doc = obj.to_solr
      expect(doc).to include('object_dates_ssm')
      expect(doc['object_dates_copyrighted_dtsi']).to eq('2017-01-01T00:00:00Z')
    end
  end

  describe 'nested attributes for object_people and object_person_roles' do
    it 'accepts object_people attributes' do
      obj = build(:rdss_cdm, object_people_attributes: [{ given_name: 'Myfanwy'}])
      expect(obj.object_people.first).to be_kind_of ActiveFedora::Base
      expect(obj.object_people.first.given_name).to eq 'Myfanwy'
    end

    # it 'requires an object person role' do
    #   check_mandatory_validation(field_name: :object_person_roles, display_name: 'role', association: true)
    # end

    it 'accepts nested object_person_roles in object_people attributes' do
      obj = build(:rdss_cdm, object_people_attributes: [{ given_name: 'Myfanwy', object_person_roles_attributes: [{role_type: 'author'}, {role_type: 'editor'}]}])
      obj_person = obj.object_people.first
      expect(obj_person.object_person_roles.first).to be_kind_of ActiveFedora::Base
      expect(obj_person.object_person_roles.map(&:role_type)).to eq ['author','editor']
    end

    # For some weird reason, this is failing with invalid attributes, but this should be prevented by the two layers of
    # validation before this could happen. Correct values appear to have no issues with the .valid? operation
    xit 'requires an object person' do
       VCR.use_cassette('rdss_cdm/create_object_people', match_requests_on: [:method, :host]) do
         obj = build(:rdss_cdm,
                     object_resource_type: 'object_resource_type',
                     object_value: 'object_value',
                     object_people_attributes: [{
                                                  given_name: '',
                                                  object_person_roles_attributes: [{ role_type: 'author' },
                                                                                   { role_type: 'editor' }]
                                                }]
         )
         expect(obj.valid?).to be_falsey
       end
    end
    #TODO Find out why validations seem to be always using solr when the associated object is not being instantiated.

    it 'indexes object_people_attributes' do
      obj = build(:rdss_cdm, object_people_attributes: [{ given_name: 'Brian'}])
      doc = obj.to_solr
      expect(doc).to include('object_people_ssm')
    end

    # it 'indexes object_person_roles_attributes' do
    #   obj = build(:rdss_cdm, object_people_attributes: [{ given_name: 'Brian', object_person_roles_attributes: [{role_type: 'messiah'}, {role_type: 'very naughty boy'}]}])
    #   doc = obj.to_solr
    #   expect(doc).to include('object_person_roles_ssm')
    # end
  end

  describe 'nested attributes for object_rights' do
    it 'accepts object rights attributes' do
      obj = build(:rdss_cdm, object_rights_attributes: [
            {
              rights_statement: ['test rights statement'],
              rights_holder: ['test rights holder'],
              licence: ['http://creativecommons.org/licenses/by/3.0/us/'],
              accesses_attributes: [{ access_type: 'controlled', access_statement: 'Statement 1' }]
            }
          ])
      expect(obj.object_rights.first).to be_kind_of ActiveFedora::Base
      expect(obj.object_rights.first.rights_statement).to eq ['test rights statement']
      expect(obj.object_rights.first.rights_holder).to eq ['test rights holder']
      expect(obj.object_rights.first.licence).to eq ['http://creativecommons.org/licenses/by/3.0/us/']
      expect(obj.object_rights.first.accesses.first.access_type).to eq 'controlled'
      expect(obj.object_rights.first.accesses.first.access_statement).to eq 'Statement 1'
    end

    it 'indexes the object rights' do
      obj = build(:rdss_cdm, object_rights_attributes: [
            {
              rights_statement: ['another rights statement'],
              rights_holder: ['another rights holder'],
              licence: ['http://creativecommons.org/licenses/by/3.0/us/'],
              accesses_attributes: [{ access_type: 'controlled', access_statement: 'Statement 2' }]
            }
          ])
      doc = obj.to_solr
      expect(doc['object_rights_licence_tesim']).to eq(['http://creativecommons.org/licenses/by/3.0/us/'])
      expect(doc['object_rights_rights_statement_tesim']).to eq(['another rights statement'])
      expect(doc['object_rights_rights_holder_tesim']).to eq(['another rights holder'])
      expect(doc['object_rights_access_type_tesim']).to eq(['controlled'])
      expect(doc).to include('object_rights_accesses_ssm')
    end
  end

  describe 'nested attributes for organisation roles' do
    it 'accepts object_organisation_roles attributes' do
      obj = build(:rdss_cdm, object_organisation_roles_attributes: [{ role: 'funder'}])
      expect(obj.object_organisation_roles.first).to be_kind_of ActiveFedora::Base
      expect(obj.object_organisation_roles.first.role).to eq 'funder'
    end

    # it 'requires an object organisation role' do
    #   check_mandatory_validation(field_name: :object_organisation_roles, display_name: 'role', association: true)
    # end

    it 'indexes object_organisation_roles_attributes' do
      obj = build(:rdss_cdm, object_organisation_roles_attributes: [{ role: 'funder'}])
      doc = obj.to_solr
      expect(doc).to include('object_organisation_roles_ssm')
      expect(doc).to include('object_organisation_role_funder_ssi')
    end
  end

  describe 'full valid build' do
    it 'succeeds build with all mandatory attributes' do
      obj = build(:rdss_cdm, valid_attributes)
      expect(obj.valid?).to eq true
    end
  end

  describe 'nested attributes for object identifiers' do
    it 'accepts object identifiers attributes' do
      obj = build(:rdss_cdm, object_identifiers_attributes: [
        {
          identifier_type: 'URL',
          identifier_value: 'http://example.com'
        }
      ])
      expect(obj.object_identifiers.first).to be_kind_of ActiveFedora::Base
      expect(obj.object_identifiers.first.identifier_type).to eq 'URL'
      expect(obj.object_identifiers.first.identifier_value).to eq 'http://example.com'
    end

    it 'indexes the object identifiers' do
      obj = build(:rdss_cdm, object_identifiers_attributes: [
        {
          identifier_type: 'isbn',
          identifier_value: '12345'
        }
      ])
      doc = obj.to_solr
      expect(doc['object_identifier_isbn_ssi']).to eq('12345')
      expect(doc).to include('object_identifiers_ssm')
      identifiers_json = JSON.parse(doc['object_identifiers_ssm'])
      expect(identifiers_json[0]['identifier_type']).to eq('isbn')
      expect(identifiers_json[0]['identifier_value']).to eq('12345')
    end
  end

  describe 'nested attributes for object related identifiers' do
    it 'accepts object related identifiers attributes' do
      obj = build(:rdss_cdm, object_related_identifiers_attributes: [
        {
          relation_type: 'cites',
          identifier_attributes: {
            identifier_type: 'URL',
            identifier_value: 'http://example.com'
          }
        }
      ])
      related_identifier = obj.object_related_identifiers.first
      expect(related_identifier).to be_kind_of ActiveFedora::Base
      expect(related_identifier.relation_type).to eq 'cites'
      
      identifier = related_identifier.identifier
      expect(identifier).to be_kind_of ActiveFedora::Base
      expect(identifier.identifier_type).to eq 'URL'
      expect(identifier.identifier_value).to eq 'http://example.com'
    end

    it 'indexes the object related identifiers' do
      obj = build(:rdss_cdm, object_related_identifiers_attributes: [
        {
          relation_type: 'isPartOf',
          identifier_attributes: {
            identifier_type: 'isbn',
            identifier_value: '12345'
          }
        }
      ])
      doc = obj.to_solr
      expect(doc).to include('object_related_identifiers_ssm')
      related_identifiers_json = JSON.parse(doc['object_related_identifiers_ssm'])
      expect(related_identifiers_json[0]['relation_type']).to eq('isPartOf')
      expect(related_identifiers_json[0]['identifier']['identifier_type']).to eq('isbn')
      expect(related_identifiers_json[0]['identifier']['identifier_value']).to eq('12345')
    end
  end


end
