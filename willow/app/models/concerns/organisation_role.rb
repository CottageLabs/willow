class OrganisationRole < ActiveFedora::Base
  include ::BasicModelBehavior
  self.human_readable_type = 'Organisation role'
  property :role, predicate: ::RDF::Vocab::PROV.hadRole, multiple: false
  belongs_to :organisation, predicate: ::RDF::Vocab::PROV.entity
  has_and_belongs_to_many :rdss_datasets, predicate: ::RDF::Vocab::PROV.wasAssociatedWith
end
