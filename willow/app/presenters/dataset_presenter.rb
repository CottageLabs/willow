class DatasetPresenter < Sufia::WorkShowPresenter
  delegate :doi, :creator_nested, :other_title, :date, :relation, :admin_metadata, to: :solr_document
end
