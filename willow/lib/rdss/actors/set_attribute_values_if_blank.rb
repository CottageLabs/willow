module Rdss
  module Actors
    class SetAttributeValuesIfBlank
      class << self
        public
        def call(env, hash)
          new(env).(hash)
        end
      end

      private
      attr_reader :attributes
      def initialize(env)
        @attributes=env.attributes
      end

      public
      def call(hash)
        hash.each do |key, value|
          attributes[key]=value if attributes[key].blank?
        end
      end
    end
  end
end