# Endpoint for objectTitle message element. This is called :title in the model.
# In the model the title is an array of values, but for the purposes of messaging and the
# form it is a single valued String
module Cdm
  module Messaging
    class ObjectTitle < MessageMapper
      
      # override MessageMapper#value to return the first value in the title array
      def value(object, _unused)
        object.title.first
      end
    end
  end
end