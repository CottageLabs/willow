#This takes an object with attributes, e.g. a model instance or an actor env and sets the values from it.
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
