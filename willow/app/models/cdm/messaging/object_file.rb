#TODO Add file in once required for the CDM. Currently, this disregards anything under :object_file in the message.
module Cdm
  module Messaging
    class ObjectFile < MessageMapper
      include AttributeMapper
      attribute_name :file_sets
    end
  end
end