# Generated via
#  `rails generate hyrax:work RdssCdm`
module Hyrax
  class RdssCdmForm < Hyrax::Forms::WorkForm
    self.model_class = ::RdssCdm
    self.terms += [
      :resource_type,
      :title, 
      :object_description  
    ]
    self.required_fields += [
      :title
    ]
  end
end
