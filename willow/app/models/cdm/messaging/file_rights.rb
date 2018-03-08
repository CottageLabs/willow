#Endpoint that has the same effective name in the mapping and the model. objectRights maps to :object_rights
module Cdm
  module Messaging
    class FileRights < MessageMapper
      def hash_value(_, object)
        {
          rightsStatement: [],
          rightsHolder: [],
          licence: [
            licenceName: '',
            licenceIdentifier: ''
          ],
          access: [
            accessType: '',
            accessStatement: ''
          ]
        }
      end
    end
  end
end