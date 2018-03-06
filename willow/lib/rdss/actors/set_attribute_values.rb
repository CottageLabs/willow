module Rdss
  module Actors
    class SetAttributeValues < SetHashValues
      private
      def initialize(attributes)
        @attributes=attributes
      end

      public
      def call(hash)
        SetHashValues.(attributes, hash)
      end
    end
  end
end
