# Standard mapping for Person. Note this is hard called from the ObjectPersonRole as part of the override defined there.
module Cdm
  module Messaging
    class PersonOrganisationUnit < EmptyMapper
      def hash_value(*)
        {
          organisation: {
            organisationJiscId: 1,
            organisationName: 'not yet implemented',
            organisationType: 1,
            organisationAddress: 'not yet implemented'
          },
          organisationUnitUuid: "470956e0-56de-4cdc-b182-c0334851a170",
          organisationUnitName: 'not yet implemeted'
        }
      end
    end
  end
end