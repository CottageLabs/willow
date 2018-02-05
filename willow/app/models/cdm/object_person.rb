module Cdm
  class ObjectPerson < ActiveFedora::Base
    property :honorific_prefix, predicate: ::RDF::Vocab::FOAF.title, multiple: false
    property :given_name, predicate: ::RDF::Vocab::FOAF.givenName, multiple: false
    property :family_name, predicate: ::RDF::Vocab::FOAF.familyName, multiple: false
    has_and_belongs_to_many :object_person_roles, class_name: 'Cdm::ObjectPersonRole', predicate: ::RDF::Vocab::VMD.affiliation
    accepts_nested_attributes_for :object_person_roles
    include Cdm::Concerns::ModelExtensions
  end
end