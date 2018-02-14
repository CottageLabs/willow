module Cdm
  module Messaging
    class ObjectPersonRole
      person_attributes :person,
                        :role

      attr_reader :object, :message
      class << self
        def call(object)
          new(object).call
        end
      end

      private
      def role

      end

      def person

      end

      def initialize(object)

      end
    end
  end
end
