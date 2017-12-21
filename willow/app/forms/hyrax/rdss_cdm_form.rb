# Generated via
#  `rails generate hyrax:work RdssCdm`
module Hyrax
  class RdssCdmForm < Hyrax::Forms::WorkForm
    self.model_class = ::RdssCdm

    self.terms = [
      :title, 
      :object_description,
      :object_keywords,
      :object_category,
      :object_version
    ]
    self.required_fields = [
      :title
    ]
  end
end
