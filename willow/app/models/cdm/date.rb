module Cdm
  # Active fedora model representing an object date for an rdss_cdm model
  class Date < ActiveFedora::Base
    property :date_value, predicate: ::RDF::Vocab::DC.date, multiple: false
    property :date_type, predicate: ::RDF::Vocab::DC.description, multiple: false

    # Define relationship with rdss_cdm model
    # predicate taken from https://github.com/samvera/hydra/wiki/Lesson---Define-Relationships-Between-Objects
    belongs_to :rdss_cdm, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf
  end
end
