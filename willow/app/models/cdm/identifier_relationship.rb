module Cdm
  # Active fedora model representing an object date for an rdss_cdm model
  class IdentifierRelationship < ActiveFedora::Base
    include Cdm::Concerns::ModelExtensions
    property :relation_type, predicate: ::RDF::Vocab::MODS.roleRelationshipRole, multiple: false
    belongs_to :identifier, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isMetadataFor, class_name: 'Cdm::Identifier'

    accepts_nested_attributes_for :identifier
  end
end