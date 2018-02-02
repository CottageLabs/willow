module Cdm
  module Json
    class ObjectPerson < ::Cdm::Json::ModelBase
      attr_reader :honorific_pre, :given_name, :family_name
      def initialize(values={})
        @honorific_pre=values['honorific_pre']
        @given_name=values['given_name']
        @family_name=values['family_name']
        super
      end
    end
  end
end