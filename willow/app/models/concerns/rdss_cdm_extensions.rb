module Concerns
  module RdssCdmExtensions
    include ::Solr::Concerns::IndexTypes

    stored_searchable :title, :object_description, :object_keywords, :object_category
  end
end