require 'securerandom'

module Hyrax
  module Notifications
    module Subscribers
      class BuildMessage
        include Hyrax::Engine.routes.url_helpers

        UNKNOWN="UNKNOWN"
        UNKNOWN_ID=0

        def initialize(event, payload)
          @event = event
          @payload = payload
          @object = payload[:object]
          @curation_concern_type = payload[:curation_concern_type]

        end

        def to_message
          msg = {
              messageHeader: {
                  messageId: messageId,
                  messageClass: messageClass,
                  messageType: messageType,
                  messageTimings: messageTimings,
                  messageSequence: messageSequence,
                  version: version
              },
              messageBody: {
                  payload: {
                    objectUuid: objectUuid,
                    objectTitle: objectTitle,
                    objectPersonRole: objectPersonRole,
                    objectDescription: objectDescription,
                    objectRights: objectRights,
                    objectDate: objectDate,
                    objectKeywords: objectKeywords,
                    objectCategory: objectCategory,
                    objectResourceType: objectResourceType,
                    objectValue: objectValue,
                    objectIdentifier: objectIdentifier,
                    objectRelatedIdentifier: objectRelatedIdentifier,
                    objectOrganisationRole: objectOrganisationRole,
                    objectPreservationEvent: objectPreservationEvent,
                    objectFile: objectFile,
                  }
              }
          }

          # puts JSON.pretty_generate(msg)
          msg
        end

        private

        ##########################
        # message header
        ##########################

        def messageId
          SecureRandom.uuid
        end

        def messageClass
          'Event'
        end

        def messageType
          @event
        end

        def messageTimings
          { publishedTimestamp: DateTime.now.rfc3339 }
        end

        def messageSequence
          {
              sequence:SecureRandom.uuid,
              position: 1,
              total: 1
          }
        end

        def version
          '0.0.1-SNAPSHOT'
        end

        ##########################
        # message body
        ##########################

        def objectUuid
          @object.id
        end

        def objectTitle
          @object.title.join('; ')
        end

        def objectPersonRole
          case
            when [Image, Book].include?(@curation_concern_type)
              @object.creator.map{|c|
                {
                    person: {
                        personGivenName: c
                    }
                }
              }
            when [Dataset, Article].include?(@curation_concern_type) && !destroy?
              @object.creator_nested.map{|c|
                {
                  person: {
                         personGivenName: (c.first_name + c.last_name).join(' '),
                         personIdentifier: c.orcid.map {|o|
                           {
                               personIdentifierValue: o,
                               personIdentifierType: UNKNOWN_ID
                           }}
                     }
                }
              }
            else
              []
          end
        end

        def objectDescription
          @object.description.to_a.join('; ')
        end

        def objectRights
          case
            when [Image, Book].include?(@curation_concern_type)
              @object.license.to_a.map{|r|
                {
                    rightsStatement: [ UNKNOWN ],
                    rightsHolder: [ UNKNOWN ],
                    licence: [{
                                  licenceIdentifier: r,
                                  licenceName: UNKNOWN
                               }],
                    access: [ {
                                   accessType: UNKNOWN_ID,
                                   accessStatement: UNKNOWN
                               } ]
                }
              }
            when [Dataset, Article].include?(@curation_concern_type) && !destroy?
              @object.license_nested.map{|r|
                {
                    rightsStatement: r.definition.to_a,
                    rightsHolder: [ UNKNOWN ],
                    licence: [ {
                                   licenceIdentifier: r.webpage.first,
                                   licenceName: r.label.first
                               } ],
                    access: [ {
                                  accessType: UNKNOWN_ID,
                                  accessStatement: UNKNOWN
                              } ]
                }
              }
            else
              []
          end
        end

        def objectDate
          case
            when [Image, Book].include?(@curation_concern_type)
              [{
                  dateValue: @object.date_created.first,
                  dateType: UNKNOWN_ID
              }]

            when [Dataset, Article].include?(@curation_concern_type) && !destroy?
              @object.date.map{|d|
                {
                    dateValue: d.date.first,
                    dateType: UNKNOWN_ID
                }
              }
            else
              []
          end
        end

        def objectKeywords
          @object.keyword.to_a
        end

        def objectCategory
          @object.resource_type.to_a
        end

        def objectResourceType
          UNKNOWN_ID
        end

        def objectValue
          UNKNOWN_ID
        end

        def objectIdentifier
          ids = @object.identifier.map{|i|
            {
                identifierValue: i,
                identifierType: UNKNOWN_ID,
                relationType: UNKNOWN_ID
            }
          }

          if [Dataset, Article].include?(@curation_concern_type)
            ids << {
                identifierValue: @object.doi,
                identifierType: UNKNOWN_ID,
                relationType: UNKNOWN_ID
            }
          end

          ids << {
              identifierValue: @object.to_global_id.to_s,
              identifierType: UNKNOWN_ID,
              relationType: UNKNOWN_ID
          }
        end

        def objectRelatedIdentifier
          case
            when [Dataset, Article].include?(@curation_concern_type)
              @object.relation.map{|r|
                {
                    identifierValue: r.url.first,
                    identifierType: UNKNOWN_ID,
                    relationType: UNKNOWN_ID
                }
              }
            else
              []
          end
        end

        def objectOrganisationRole
          [{
               organisation: {
                  organisationJiscId: UNKNOWN_ID,
                  organisationName: UNKNOWN,
                  organisationType: UNKNOWN_ID,
                  organisationAddress: UNKNOWN
              },
               role: UNKNOWN_ID
           }]
        end

        def objectPreservationEvent
          [{
              preservationEventValue: @event,
              preservationEventType: UNKNOWN_ID,
              preservationEventDetail: @curation_concern_type
           }]
        end

        def objectFile
          files = []
          if !destroy? # cannot send files with delete as they are gone
            @object.file_sets.each do |fs|
              files << {
                  fileUuid: fs.id,
                  # NB: line below replaced temporarily to for https://jiscdev.atlassian.net/browse/RDSSSAM-118
                  # override the default url host with the SAMVERA_INTERNAL_HOST environment variable if it is set
                  # fileIdentifier: download_url(fs, host: Rails.application.routes.default_url_options[:host]),
                  fileIdentifier: download_url(fs, host: (ENV['SAMVERA_INTERNAL_HOST'] || Rails.application.routes.default_url_options[:host])),
                  fileName: fs.first_title,
                  fileSize: fs.file_size.first.try(:to_i),
                  fileChecksum: fs.original_checksum.map{|c| {
                      checksumType: UNKNOWN_ID,
                      checksumValue: c
                  }},
                  fileCompositionLevel: UNKNOWN,
                  fileDateModified: [
                      {
                          dateValue: UNKNOWN,
                          dateType: UNKNOWN_ID
                      }
                  ],
                  fileUse: UNKNOWN_ID,
                  filePreservationEvent: [
                    {
                        preservationEventValue: UNKNOWN,
                        preservationEventType: UNKNOWN_ID,
                        preservationEventDetail: UNKNOWN
                    }
                  ],
                  fileUploadStatus: UNKNOWN_ID,
                  fileStorageStatus: UNKNOWN_ID,
                  fileStorageLocation: UNKNOWN,
                  fileStorageType: UNKNOWN_ID
              }
            end
          end
          files
        end

        def destroy?
          @event == Hyrax::Notifications::Events::METADATA_DELETE
        end

        def inactive?
          @object.state.id == 'http://fedora.info/definitions/1/0/access/ObjState#inactive'.freeze
        end

        def active?
          @object.state.id == 'http://fedora.info/definitions/1/0/access/ObjState#active'.freeze
        end

      end
    end
  end
end
