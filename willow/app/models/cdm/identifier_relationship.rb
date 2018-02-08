module Cdm
  # Active fedora model representing an object date for an rdss_cdm model
  class IdentifierRelationship < ActiveFedora::Base
    include Cdm::Concerns::ModelExtensions
    property :relation_type, predicate: ::RDF::Vocab::MODS.roleRelationshipRole, multiple: false
    belongs_to :identifier, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isMetadataFor, class_name: 'Cdm::Identifier'

    accepts_nested_attributes_for :identifier

    # Override identifier_attributes
    # There is a wierd bug in active fedora where for a belongs_to association, a new record will lose it's attributes
    # We get around this by after an assignment, if the identifier is a new record, reassign the attributes before a save
    def identifier_attributes= atts
      super atts
      if identifier && identifier.new_record?
        identifier.attributes= atts
      end
    end
  end
end