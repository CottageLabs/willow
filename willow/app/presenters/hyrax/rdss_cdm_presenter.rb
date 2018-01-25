# Generated via
#  `rails generate hyrax:work RdssCdm`
module Hyrax
  class RdssCdmPresenter < Hyrax::WorkShowPresenter
    delegate :title,
             :object_description,
             :object_keywords,
             :object_category,
             :object_resource_type,
             :object_value,
             :object_dates,
             :object_person,
             :object_person_role,
             to: :solr_document
  end
end
