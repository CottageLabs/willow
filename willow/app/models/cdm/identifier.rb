module Cdm
  # Active fedora model representing an object date for an rdss_cdm model
  class Identifier < ActiveFedora::Base
    include Cdm::Concerns::ModelExtensions
    #property :date_value, predicate: ::RDF::Vocab::DC.date, multiple: false
    property :identifier_value, predicate: ::RDF::Vocab::DataCite.hasIdentifier, multiple: false
    property :identifier_type, predicate: ::RDF::Vocab::DataCite.usesIdentifierScheme, multiple: false
  end
end
