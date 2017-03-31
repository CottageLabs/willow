# Generated via
#  `rails generate curation_concerns:work MyWorkType`
module CurationConcerns
  class MyWorkTypeForm < Sufia::Forms::WorkForm
    self.model_class = ::MyWorkType
    self.terms += [:resource_type]

  end
end
