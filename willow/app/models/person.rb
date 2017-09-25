class Person < ActiveFedora::Base
  include ::BasicModelBehavior

  self.indexer = AgentIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []

  self.human_readable_type = 'Person'

  property :first_name, predicate: ::RDF::Vocab::FOAF.givenName do |index|
    index.as :stored_searchable
  end
  property :last_name, predicate: ::RDF::Vocab::FOAF.familyName do |index|
    index.as :stored_searchable
  end
  property :name, predicate: ::RDF::Vocab::VCARD.hasName do |index|
    index.as :stored_searchable, :facetable
  end
  property :role, predicate: ::RDF::Vocab::VMD.role do |index|
    index.as :stored_searchable, :facetable
  end
  property :identifier_nested, predicate: ::RDF::Vocab::Identifiers.id, class_name: "ObjectIdentifier"
  property :contact_nested, predicate: ::RDF::Vocab::DCAT.contactPoint, class_name: "ContactStatement"
  include AgentNestedAttributes
  # Associate with organisation
  has_and_belongs_to_many :organisations, predicate: ::RDF::Vocab::VMD.affiliation
  # ToDo - associating with person role for datasets
  #   has_many :datasets, through: :person_roles
end
