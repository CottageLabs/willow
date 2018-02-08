module Cdm
  class ObjectPersonRole < ActiveFedora::Base
    include Cdm::Concerns::ModelExtensions
    property :role_type, predicate: ::RDF::Vocab::SIOC.has_function, multiple: false
    has_and_belongs_to_many :object_people,
                            class_name: 'Cdm::ObjectPerson',
                            predicate: ::RDF::Vocab::VMD.affiliation,
                            inverse_of: :object_person_role,
                            autosave: true
  end
end