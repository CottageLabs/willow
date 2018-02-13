module Cdm
  class ObjectOrganisationRole < ActiveFedora::Base
    include Cdm::Concerns::ModelExtensions
    property :role, predicate: ::RDF::Vocab::PROV.hadRole, multiple: false
  end
end