# Generated via
#  `rails generate hyrax:work RdssDataset`
module Hyrax
  class RdssDatasetForm < Hyrax::Forms::WorkForm
    self.model_class = ::RdssDataset
    self.terms += [:resource_type]
  end
end
