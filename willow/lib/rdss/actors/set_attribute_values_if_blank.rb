module Rdss
  module Actors
    class SetAttributeValuesIfBlank < SetAttributeValues
      def call(hash)
        SetHashValuesIfBlank.(attributes, hash)
      end
    end
  end
end