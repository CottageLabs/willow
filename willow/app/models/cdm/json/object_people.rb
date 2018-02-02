module Cdm
  module Json
    class ObjectPeople
      attr_reader :people
      delegate :map, :"[]", to: :people
      def initialize(string)
        @people=JSON.parse(string).map{|x| ::Cdm::Json::ObjectPerson.new(x)}
      end
    end
  end
end
