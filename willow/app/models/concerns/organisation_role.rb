class OrganisationRole < ActiveFedora::Base
  include ::BasicModelBehavior
  self.human_readable_type = 'Person role'
  property :role, predicate: ::RDF::Vocab::PROV.hadRole, multiple: false
  belongs_to :organisation, predicate: ::RDF::Vocab::PROV.entity
end
