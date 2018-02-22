module Cdm
  class Organisation < ActiveFedora::Base
    # TODO predicate has to change
    property :jisc_id, predicate: ::RDF::Vocab::DataCite.hasIdentifier, multiple: false
    property :name, predicate: ::RDF::Vocab::VCARD.hasName, multiple: false
    property :address, predicate: ::RDF::Vocab::VCARD.hasAddress, multiple: true
    property :organisation_type, predicate: ::RDF::Vocab::ORG.organization, multiple: false
  end
end
