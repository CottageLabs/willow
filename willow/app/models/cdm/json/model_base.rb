module Cdm
  module Json
    class ModelBase
      attr_reader :id, :rdss_cdm_id
      def initialize(values={})
        @id=values['id']
        @rdss_cdm_id=values['rdss_cdm_id']
      end
    end
  end
end