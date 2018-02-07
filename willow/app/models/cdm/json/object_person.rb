module Cdm
  module Json
    class ObjectPerson < ::Cdm::Json::ModelBase
      attr_reader :honorific_prefix, :given_name, :family_name, :roles
      def initialize(values={}, converter=::Cdm::Json::ObjectPersonRole)
        @honorific_prefix=values['honorific_prefix']
        @given_name=values['given_name']
        @family_name=values['family_name']
        @roles=values['object_person_roles'].map {|x| converter.new(x) }
        super(values)
      end

      def name
        [honorific_prefix, given_name, family_name].join(' ').squish
      end
    end
  end
end