module Cdm
  module Json
    class Organisation < ModelBase
      attr_reader :address, :jisc_id, :name, :organisation_type

      def initialize(values = {})
        @address = values['address']
        @jisc_id = values['jisc_id']
        @name = values['name']
        @organisation_type = values['organisation_type']
      end
    end
  end
end
