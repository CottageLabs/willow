class DatasetPresenter < Sufia::WorkShowPresenter
  delegate :doi, :other_title, :date, :relation, :admin_metadata, to: :solr_document
end
