# Generated via
#  `rails generate hyrax:work RdssCdm`
module Hyrax
  class RdssCdmForm < Hyrax::Forms::WorkForm
    self.model_class = ::RdssCdm

    self.terms -= [
      # These fields are not present in the RDSS CDM model,
      # but are hard-coded in Hyrax::Forms::WorkForm
      :label, 
      :relative_path, 
      :import_url, 
      :resource_type,
      :creator, 
      :contributor, 
      :description, 
      :keyword, 
      :license,
      :rights_statement,
      :publisher, 
      :date_created, 
      :subject, 
      :language, 
      :identifier, 
      :based_near, 
      :related_url, 
      :bibliographic_citation, 
      :source
    ]
    self.required_fields -= [
      # These fields are not present in the RDSS CDM model,
      # but are hard-coded in Hyrax::Forms::WorkForm
      :creator, 
      :keyword, 
      :rights_statement, 
      :title
    ]

    self.terms += [
      :title, 
      :object_description,
      :object_keywords,
      :object_category,
      :object_version
    ]
    self.required_fields += [
      :title
    ]
  end
end
