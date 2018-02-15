module Cdm
  module Messaging
    class GenerateMessage
      class << self
        private
        def decoders
          %i(
          object_uuid
          object_title
          object_person_role
          object_description
          object_rights
          object_date
          object_keywords
          object_category
          object_resource_type
          object_value
          object_identifier
          object_related_identifier
          object_organisation_role
          object_preservation_event
          object_file
          )
        end

        def call(object)
          decoders.map {|x| decoder.classify.send(call, object)}.to_json
        end
      end
    end
  end
end
