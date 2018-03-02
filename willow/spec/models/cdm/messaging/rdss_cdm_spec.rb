require 'rails_helper'

RSpec.describe ::Cdm::Messaging::RdssCdm do
  describe 'generates a message body with a passed CDM object' do
    let(:attributes) {
      {
        object_uuid: nil,
        title: ['title'],
        object_category: ['category'],
        object_dates_attributes: [{ date_value: "2002-10-02T10:00:00-05:00", date_type: 'accepted' }],
        object_description: 'description',
        object_identifiers_attributes: [{ identifier_value: 'http://example.com', identifier_type: 'url' }],
        object_keywords: ['keyword'],
        object_organisation_roles_attributes: [
          {
            organisation_attributes: {
              jisc_id: 1,
              name: "string",
              organisation_type: 'further_education',
              address: "string"
            },
            role: 'funder'
          }
        ],
        object_related_identifiers_attributes: [
          {
            relation_type: 'cites',
            identifier_attributes: {
              identifier_type: 'url',
              identifier_value: 'http://example.com'
            }
          }
        ],
        object_resource_type: 'artDesignItem',
        object_people_attributes: [
          {
            honorific_prefix: 'Mr.',
            given_name: 'Paul',
            family_name: 'Mak',
            mail: 'paul@example.com',
            object_person_roles_attributes: [
              { role_type: 'author' }
            ]
          }
        ],
        object_rights_attributes: [
          {
            rights_statement: ['Rights statement'],
            rights_holder: ['Rights holder'],
            licence: ['https://creativecommons.org/publicdomain/zero/1.0/'],
            accesses_attributes: [{ access_type: 'controlled', access_statement: 'Statement 1' }]
          },
        ],
        object_value: 'normal'
      }
    }
    let(:final_body) {
      {
        "objectUuid": nil,
        "objectTitle": "title",
        "objectCategory": ["category"],
        "objectDate": [{ "dateValue": "2002-10-02T10:00:00-05:00", "dateType": 1 }],
        "objectDescription": "description",
        "objectIdentifier": [{ "identifierValue": "http://example.com", "identifierType": 18 }],
        "objectKeywords": ["keyword"],
        "objectValue": 1,
        "objectPersonRole": [
          {
            "person": {
              "personUuid": nil,
              "personIdentifier": [
                "personIdentifierType": 1,
                "personIdentifierValue": 'deprecated'
              ],
              "personEntitlement": [1],
              "personAffiliation": [1],
              "personGivenName": "Paul",
              "personCn": "Mr. Paul Mak",
              "personSn": "Mak",
              :personTelephoneNumber=>"1",
              :personMail=>"paul@example.com",
              :personOrganisationUnit=>{
                :organisation=>{
                  :organisationJiscId=>1,
                  :organisationName=>"deprecated",
                  :organisationType=>1,
                  :organisationAddress=>"deprecated"
                },
                :organisationUnitUuid=>"470956e0-56de-4cdc-b182-c0334851a170",
                :organisationUnitName=>"deprecated"}
            },
            "role": 20
          }
        ],
        "objectRights": [
          {
            "rightsStatement": [
              "Rights statement"
            ],
            "rightsHolder": [
              "Rights holder"
            ],
            "licence": [
              {
                "licenceName": "Open Data Commons Public Domain Dedication and Licence (ODC PDDL)",
                "licenceIdentifier": 'https://creativecommons.org/publicdomain/zero/1.0/'
              }
            ],
            "access": [
              {
                "accessType": 3,
                "accessStatement": "Statement 1"
              }
            ]
          }
        ],
        "objectResourceType": 1,
        "objectRelatedIdentifier": [
          {
            "relationType": 1,
            "identifierType": 18,
            "identifierValue": "http://example.com",
          }
        ],
        "objectOrganisationRole": [
          {
            "organisation": {
              "organisationJiscId": 1,
              "organisationName": "string",
              "organisationType": 4,
              "organisationAddress": "string"
            },
            "role": 1
          }
        ]
      }
    }
    let(:cdm_object) { ::RdssCdm.new(attributes) }

    it 'should generate a message body hash as the payload' do
      VCR.use_cassette('rdss_cdm_messaging', match_requests_on: [:method, :host]) do
        expect(described_class.(cdm_object)).to eq(final_body)
      end
    end
  end
end