class PersonRole < ActiveFedora::Base
  include ::BasicModelBehavior
  self.human_readable_type = 'Person role'
  property :role, predicate: ::RDF::Vocab::PROV.hadRole, multiple: false
  belongs_to :person, predicate: ::RDF::Vocab::PROV.entity
  has_and_belongs_to_many :rdss_datasets, predicate: ::RDF::Vocab::PROV.wasAssociatedWith
end
