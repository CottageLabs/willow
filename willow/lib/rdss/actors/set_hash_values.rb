module Rdss
  module Actors
    class SetHashValues
      class << self
        public
        def call(attributes, hash)
          new(attributes).(hash)
        end
      end

      private
      attr_reader :attributes
      def initialize(attributes)
        @attributes=attributes
      end

      public
      def call(hash)
        hash.each { |key, value| attributes[key]=value }
      end
    end
  end
end