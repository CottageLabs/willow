module Cdm
  module Json
    class ObjectPerson < ::Cdm::Json::ModelBase
      attr_reader :honorific_prefix, :given_name, :family_name
      def initialize(values={})
        @honorific_prefix=values['honorific_prefix']
        @given_name=values['given_name']
        @family_name=values['family_name']
        super
      end
    end
  end
end