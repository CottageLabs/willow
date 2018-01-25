module Cdm
  # Active fedora model representing an object rights object for an rdss_cdm model
  class Rights < ActiveFedora::Base
    property :rights_statement, predicate: ::RDF::Vocab::DC.RightsStatement
    property :rights_holder, predicate: ::RDF::Vocab::DC.rightsHolder
    property :license, predicate: ::RDF::Vocab::DC.license
    # TODO deep nested association for access object

    # Define relationship with rdss_cdm model
    # predicate taken from https://github.com/samvera/hydra/wiki/Lesson---Define-Relationships-Between-Objects
    belongs_to :rdss_cdm, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf

    has_many :accesses, class_name: 'Cdm::Access'
  end
end
