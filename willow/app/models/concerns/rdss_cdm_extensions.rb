module Concerns
  module RdssCdmExtensions
    include ::Solr::Concerns::IndexTypes

    stored_searchable :title, :object_description, :object_keywords, :object_category, :object_resource_type, :object_value, :object_person, :object_person_role
    displayable :object_dates
  end
end
