# Generated via
#  `rails generate hyrax:work RdssDataset`
module Hyrax
  class RdssDatasetPresenter < Hyrax::WorkShowPresenter
    delegate :creator_nested, :date, :rights_nested, :identifier_nested,
      :relation, :category, :rating, to: :solr_document
  end
end
