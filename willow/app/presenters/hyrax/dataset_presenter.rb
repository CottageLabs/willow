# Generated via
#  `rails generate hyrax:work Dataset`
module Hyrax
  class DatasetPresenter < Hyrax::WorkShowPresenter
    delegate :doi, :other_title, :creator_nested, :date, :rights_nested,
      :relation, :subject_nested, :admin_metadata, to: :solr_document
  end
end
