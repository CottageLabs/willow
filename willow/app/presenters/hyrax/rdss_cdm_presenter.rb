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
             :object_people,
             :object_person_roles,
             :object_rights_license,
             :object_rights_rights_statement,
             :object_rights_rights_holder,
             :object_rights_accesses,
             :object_organisation_roles,
             to: :solr_document
  end
end
