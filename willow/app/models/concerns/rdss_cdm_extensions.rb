module Concerns
  module RdssCdmExtensions
    include ::Solr::Concerns::IndexTypes

    stored_searchable :title, :object_description, :object_keywords, :object_category, :object_resource_type, :object_value
  end
end