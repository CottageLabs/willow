module Cdm
  module Json
    class ObjectPersonRoles
      attr_reader :role_types
      delegate :map, :"[]", to: :role_types
      def initialize(string)
        @role_types=JSON.parse(string).map{|x| ::Cdm::Json::ObjectPersonRole.new(x)}
      end
    end
  end
end
