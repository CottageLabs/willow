module Concerns
  module RdssExtensions
    include ::Solr::Concerns::IndexTypes

    stored_searchable :doi, :coverage, :apc, :tagged_version, :category, :rating, :rights_holder, :rdss_version
    displayable :other_title, :creator_nested, :date, :license_nested, :relation, :subject_nested, :admin_metadata
    displayable :project, :identifier_nested, :organisation_nested, :preservation_nested
  end
end
