# Generated via
#  `rails generate hyrax:work Dataset`
module Hyrax
  class DatasetPresenter < Hyrax::WorkShowPresenter
    delegate :doi, :other_title, :creator_nested, :date, :license_nested,
      :relation, :subject_nested, :admin_metadata, :identifier_nested, to: :solr_document
  end
end
