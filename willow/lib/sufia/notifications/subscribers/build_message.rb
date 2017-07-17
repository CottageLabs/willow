require 'securerandom'

module Sufia
  module Notifications
    module Subscribers
      class BuildMessage

        UNKNOWN="UNKNOWN"
        UNKNOWN_ID=0

        def initialize(event, payload)
          @event = event
          @payload = payload
          @object = payload[:object]
          @curation_concern_type = payload[:curation_concern_type]

        end

        def to_message
          puts "\n\nBUILDING MESSAGE --------------------------------"
          puts "Incoming"
          puts "@payload:\t#{@payload}"
          puts "@object[:depositor]:\t#{@object[:depositor]}"
          puts "@curation_concern_type:\t#{@curation_concern_type}"

          puts "@curation_concern_type.class:\t#{@curation_concern_type.class}"

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

          puts "Outgoing message"
          puts JSON.pretty_generate(msg)
          puts "DONE --------------------------------\n\n"
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
          case @event
            when 'create_work.sufia'
              'CREATE'
            when 'update_work.sufia'
              'UPDATE'
            when 'delete_work.sufia'
              'DELETE'
            else
              "UNKNOWN-#{@event}"
          end
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
            when @curation_concern_type.eql?(Work)
              @object.creator.map{|c|
                {
                    person: {
                        personGivenName: c
                    }
                }
              }
            when [Dataset, Article].include?(@curation_concern_type)
              @object.creator_nested.map{|c|
                {
                  person: {
                         personGivenName: (c.first_name + c.last_name).join(' '),
                         personIdentifier: c.orcid.map {|o| {personIdentifierValue: o }}
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
            when @curation_concern_type.eql?(Work)
              @object.rights.to_a.map{|r|
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
            when [Dataset, Article].include?(@curation_concern_type)
              @object.rights_nested.map{|r|
                {
                    rightsStatement: r.definition,
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
            when @curation_concern_type.eql?(Work)
              [{
                  dateValue: UNKNOWN,
                  dateType: UNKNOWN_ID
              }]

            when [Dataset, Article].include?(@curation_concern_type)
              @object.date.map{|d|
                {
                    dateValue: d.date,
                    dateType: UNKNOWN_ID
                }
              }
            else
              []
          end
        end

        def objectKeywords
          []
        end

        def objectCategory
          []
        end

        def objectResourceType
          1
        end

        def objectValue
          1
        end

        def objectIdentifier
          []
        end

        def objectRelatedIdentifier
          []
        end

        def objectOrganisationRole
          []
        end

        def objectPreservationEvent
          []
        end

        def objectFile
          []
        end




      end
    end
  end
end
