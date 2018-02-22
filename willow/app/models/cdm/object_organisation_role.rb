module Cdm
  class ObjectOrganisationRole < ActiveFedora::Base
    include Cdm::Concerns::ModelExtensions
    property :role, predicate: ::RDF::Vocab::PROV.hadRole, multiple: false

    belongs_to :organisation, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf, class_name: 'Cdm::Organisation'
    accepts_nested_attributes_for :organisation

    # Override organisation_attributes
    # There is a wierd bug in active fedora where for a belongs_to association,
    # a new record will lose it's attributes
    # We get around this by after an assignment, if the organisation is a new record,
    # reassign the attributes before a save
    def organisation_attributes=(atts)
      super atts
      organisation.attributes = atts if organisation&.new_record?
    end
  end
end
