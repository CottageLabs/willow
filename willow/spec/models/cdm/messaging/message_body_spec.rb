require 'rails_helper'
require 'vcr'
#
VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
end

RSpec.describe ::Cdm::Messaging::MessageBody do
  describe 'generates a message body with a passed CDM object' do
    let(:attributes) {
      {
        id: '5680e8e0-28a5-4b20-948e-fd0d08781e0b',
        title: ['string'],
        object_people_attributes: [
          {
            honorific_prefix: 'string',
            given_name: 'string',
            family_name: 'string',
            object_person_roles_attributes: [
              { role: 'author' }
            ]
          }
        ],
        object_description: 'string',
        object_rights_attributes: [
          {
            rights_statement: ['string'],
            rights_holder: ['string'],
            license: ['http://creativecommons.org/licenses/by/3.0/us/'],
            accesses_attributes: [{ access_type: 'controlled', access_statement: 'Statement 1' }]
          }

        ],

      }
    }
    let(:final_body) {
      {
        "objectUuid": "5680e8e0-28a5-4b20-948e-fd0d08781e0b",
        "objectTitle": "string",
        "objectPersonRole": [
          {
            "person": {
              "personUuid": "27811a4c-9cb5-4e6d-a069-5c19288fae58",
              "personIdentifier": [
                {
                  "personIdentifierValue": "string",
                  "personIdentifierType": 1
                }
              ],
              "personEntitlement": [
                1
              ],
              "personAffiliation": [
                1
              ],
              "personGivenName": "string",
              "personCn": "string",
              "personSn": "string",
              "personTelephoneNumber": "string",
              "personMail": "person@net",
              "personOrganisationUnit": {
                "organisationUnitUuid": "28be7f16-0e70-461f-a2db-d9d7c64a8f17",
                "organisationUnitName": "string",
                "organisation": {
                  "organisationJiscId": 1,
                  "organisationName": "string",
                  "organisationType": 1,
                  "organisationAddress": "string"
                }
              }
            },
            "role": 1
          }
        ],
        "objectDescription": "string",
        "objectRights": [
          {
            "rightsStatement": [
              "string"
            ],
            "rightsHolder": [
              "string"
            ],
            "licence": [
              {
                "licenceName": "string",
                "licenceIdentifier": "string"
              }
            ],
            "access": [
              {
                "accessType": 1,
                "accessStatement": "string"
              }
            ]
          }
        ],
        "objectDate": [
          {
            "dateValue": "2002-10-02T10:00:00-05:00",
            "dateType": 1
          }
        ],
        "objectKeywords": [
          "string"
        ],
        "objectCategory": [
          "string"
        ],
        "objectResourceType": 1,
        "objectValue": 1,
        "objectIdentifier": [
          {
            "identifierValue": "string",
            "identifierType": 1,
            "relationType": 1
          }
        ],
        "objectRelatedIdentifier": [
          {
            "identifierValue": "string",
            "identifierType": 1,
            "relationType": 1
          }
        ],
        "objectOrganisationRole": [
          {
            "organisation": {
              "organisationJiscId": 1,
              "organisationName": "string",
              "organisationType": 1,
              "organisationAddress": "string"
            },
            "role": 1
          }
        ],
        "objectPreservationEvent": [
          {
            "preservationEventValue": "string",
            "preservationEventType": 1,
            "preservationEventDetail": "string"
          }
        ],
        "objectFile": [
          {
            "fileUuid": "e150c4ab-0370-4e5a-8722-7fb3369b7017",
            "fileIdentifier": "string",
            "fileName": "string",
            "fileSize": 1,
            "fileLabel": "string",
            "fileDateCreated": {
              "dateValue": "2002-10-02T10:00:00-05:00",
              "dateType": 1
            },
            "fileRights": {
              "rightsStatement": [
                "string"
              ],
              "rightsHolder": [
                "string"
              ],
              "licence": [
                {
                  "licenceName": "string",
                  "licenceIdentifier": "string"
                }
              ],
              "access": [
                {
                  "accessType": 1,
                  "accessStatement": "string"
                }
              ]
            },
            "fileChecksum": [
              {
                "checksumUuid": "df23b46b-6b64-4a40-842f-5ad363bb6e11",
                "checksumType": 1,
                "checksumValue": "string"
              }
            ],
            "fileFormatType": "string",
            "fileCompositionLevel": "string",
            "fileHasMimeType": true,
            "fileDateModified": [
              {
                "dateValue": "2002-10-02T10:00:00-05:00",
                "dateType": 1
              }
            ],
            "filePuid": [
              "string"
            ],
            "fileUse": 1,
            "filePreservationEvent": [
              {
                "preservationEventValue": "string",
                "preservationEventType": 1,
                "preservationEventDetail": "string"
              }
            ],
            "fileUploadStatus": 1,
            "fileStorageStatus": 1,
            "fileLastDownloaded": {
              "dateValue": "2002-10-02T10:00:00-05:00",
              "dateType": 1
            },
            "fileTechnicalAttributes": [
              "string"
            ],
            "fileStorageLocation": "https://tools.ietf.org/html/rfc3986",
            "fileStoragePlatform": {
              "storagePlatformUuid": "f2939501-2b2d-4e5c-9197-0daa57ccb621",
              "storagePlatformName": "string",
              "storagePlatformType": 1,
              "storagePlatformCost": "string"
            }
          }
        ]
      }
    }
    let(:cdm_object) { ::RdssCdm.new(attributes) }

    it 'should generate a message body hash' do
      puts(described_class.(cdm_object))
      expect(described_class.(cdm_object)).to eq(final_body)
    end
  end
end