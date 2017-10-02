# Generated via
#  `rails generate hyrax:work RdssDataset`
module Hyrax
  class RdssDatasetPresenter < Hyrax::WorkShowPresenter
    delegate :creator_nested, :organisation_nested, :date, :rights_holder, :license_nested, :identifier_nested,
      :relation, :category, :rating, :preservation_nested, to: :solr_document
  end
end
