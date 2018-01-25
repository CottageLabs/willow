module Cdm
  # Active fedora model representing an object rights object for an rdss_cdm model
  class Access < ActiveFedora::Base
    # for access statement we use rights statement again, it also defines access information
    # http://dublincore.org/usage/terms/history/#RightsStatement-001
    property :access_statement, predicate: ::RDF::Vocab::DC.RightsStatement, multiple: false
    property :access_type, predicate: ::RDF::Vocab::DC.accessRights, multiple: false
    # TODO deep nested association for access object

    # Define relationship with cdm rights model
    # predicate taken from https://github.com/samvera/hydra/wiki/Lesson---Define-Relationships-Between-Objects
    belongs_to :rights, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf, class_name: 'Cdm::Rights'
  end
end
