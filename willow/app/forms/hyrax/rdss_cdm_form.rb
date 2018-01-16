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
      :object_version,
      :object_resource_type,
      :object_value,
      :object_version,
      :object_dates
    ]
    self.required_fields = [
      :title,
      :object_resource_type,
      :object_value
    ]

    # utility methods to allow nested fields to work with the hyrax form
    # Taken from https://github.com/curationexperts/laevigata/

    # In the view we have "fields_for :object_dates".
    # This method is needed to make fields_for behave as an
    # association and populate the form with the correct
    # object_date data.
    delegate :object_dates_attributes=, to: :model

    # We need to call '.to_a' on committee_members to force it
    # to resolve.  Otherwise in the form, the fields don't
    # display the object_dates's type and value
    # Instead they display something like:
    # '#<ActiveTriples::Relation:0x007fb564969c88>'
    def object_dates
      model.object_dates.build if model.object_dates.blank?
      model.object_dates.to_a
    end

    # Permitted parameters for nested attributes
    # These need to define the incoming parameters for any nested form attributes so that
    # strong_params permits them
    def self.permitted_object_date_params
      [:id,
       :_destroy,
       {
         date_value: [],
         date_type: []
       }]
    end

    def self.build_permitted_params
      permitted = super
      # add in object_date attributes
      permitted << { object_dates_attributes: permitted_object_date_params }
      permitted
    end
  end
end
