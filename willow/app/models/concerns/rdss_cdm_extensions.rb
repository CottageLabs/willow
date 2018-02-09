module Concerns
  module RdssCdmExtensions
    include ::Solr::Concerns::IndexTypes

    stored_searchable :title,
                      :object_description,
                      :object_keywords,
                      :object_category,
                      :object_resource_type,
                      :object_value,
                      :object_rights_license,
                      :object_rights_rights_statement,
                      :object_rights_rights_holder

    displayable :object_dates,
                :object_person_roles,
                :object_people
                :object_rights_accesses
  end
end
