module Cdm
  class OrganisationRole < ActiveFedora::Base
    include Cdm::Concerns::ModelExtensions
    property :role, predicate: ::RDF::Vocab::DC.role, multiple: false
  end
end