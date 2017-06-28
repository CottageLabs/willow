class ArticlePresenter < Sufia::WorkShowPresenter
  delegate :doi, :publisher, :coverage, :apc, :version, :creator_nested, :date, :rights_nested,
  :relation, :subject_nested, :project, :admin_metadata, to: :solr_document
end
