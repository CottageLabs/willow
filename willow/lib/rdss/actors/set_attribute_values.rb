module Rdss
  module Actors
    class SetAttributeValues < SetHashValues
      private
      def initialize(env)
        @attributes=env.attributes
      end

      public
      def call(hash)
        SetHashValues.(attributes, hash)
      end
    end
  end
end