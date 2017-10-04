# Generated via
#  `rails generate hyrax:work Article`
module Hyrax
  class ArticlePresenter < Hyrax::WorkShowPresenter
    delegate :doi, :publisher, :coverage, :apc, :tagged_version, :creator_nested, :date, :license_nested,
      :relation, :subject_nested, :project, :admin_metadata, :identifier_nested, to: :solr_document
  end
end
