module Cdm
  # Active fedora model representing an object rights object for an rdss_cdm model
  class Rights < ActiveFedora::Base
    property :rights_statement, predicate: ::RDF::Vocab::DC.RightsStatement
    property :rights_holder, predicate: ::RDF::Vocab::DC.rightsHolder
    property :licence, predicate: ::RDF::Vocab::DC.license
    # TODO deep nested association for access object

    # Grr. It's not a license, it's a licence. This breaks the messaging when it's wrong.
    # TODO Fix it properly
    alias_attribute :licence, :license

    # Define relationship with rdss_cdm model
    # predicate taken from https://github.com/samvera/hydra/wiki/Lesson---Define-Relationships-Between-Objects
    belongs_to :rdss_cdm, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf

    has_many :accesses, class_name: 'Cdm::Access'

    accepts_nested_attributes_for :accesses, reject_if: :accesses_blank?, allow_destroy: true

    # accesses_blank
    # Reject a nested access if the value for access_type is not set
    def accesses_blank?(attributes)
      attributes[:access_type].blank?
    end
  end
end
