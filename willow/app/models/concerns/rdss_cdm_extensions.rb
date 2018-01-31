module Concerns
  module RdssCdmExtensions
    include ::Solr::Concerns::IndexTypes

    stored_searchable :title,
                      :object_description,
                      :object_keywords,
                      :object_category,
                      :object_resource_type,
                      :object_value,

    displayable :object_dates,
                :object_person_roles,
  end
end
