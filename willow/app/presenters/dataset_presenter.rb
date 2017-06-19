class DatasetPresenter < Sufia::WorkShowPresenter
  delegate :doi, :other_title, :creator_nested, :date, :rights_nested, :relation, :admin_metadata, to: :solr_document
end
