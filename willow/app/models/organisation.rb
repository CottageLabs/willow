class Organisation < ActiveFedora::Base
  include ::BasicModelBehavior

  self.indexer = AgentIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []

  self.human_readable_type = 'Organisation'

  property :org_name, predicate: ::RDF::Vocab::VCARD.hasName do |index|
    index.as :stored_searchable, :facetable
  end
  property :org_type, predicate: ::RDF::Vocab::DC.description do |index|
    index.as :stored_searchable, :facetable
  end
  property :identifier_nested, predicate: ::RDF::Vocab::Identifiers.id, class_name: "ObjectIdentifier"
  property :contact_nested, predicate: ::RDF::Vocab::DCAT.contactPoint, class_name: "ContactStatement"
  include AgentNestedAttributes
  # Associate with person
  has_many :persons
  # ToDo - associating with organisation role for datasets
  #   has_many :datasets, through: :organisation_roles
end
