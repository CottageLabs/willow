# Generated via
#  `rails generate hyrax:work RdssCdm`
module Hyrax
  class RdssCdmForm < Hyrax::Forms::WorkForm
    include Concerns::RelationArrayMapper
    self.model_class = ::RdssCdm

    self.terms = [
      :title,
      :object_description,
      :object_keywords,
      :object_category,
      :object_version,
      :object_resource_type,
      :object_value,
      :object_people,
      :object_dates,
    ]

    self.required_fields = [
      :title,
      :object_resource_type,
      :object_value,
      :object_people,
    ]

    mapped_arrays :object_dates

    def object_people
      convert_value_to_array(model.object_people)
    end

    # utility methods to allow nested fields to work with the hyrax form
    # Taken from https://github.com/curationexperts/laevigata/

    # In the view we have "fields_for :object_dates".
    # This method is needed to make fields_for behave as an
    # association and populate the form with the correct
    # object_date data.
    delegate :object_dates_attributes=,
             :object_people_attributes=,
             to: :model

    # Permitted parameters for nested attributes
    # These need to define the incoming parameters for any nested form attributes so that
    # strong_params permits them
    def self.permitted_object_date_params
      [:id,
       :_destroy,
       [
         :date_value,
         :date_type
        ]
      ]
    end

    # def self.permitted_object_person_roles_nested
    #   [
    #     :id,
    #     :_destroy,
    #     [
    #       :role_type,
    #       people: permitted_object_person_params
    #     ]
    #   ]
    # end
    #
    def self.permitted_object_person_nested
      [
        :id,
        :honorific_prefix,
        :given_name,
        :family_name,
        :_destroy,
        roles: permitted_object_person_roles_params
      ]
    end

    def self.permitted_object_person_roles_params
      [
        :id,
        :_destroy,
        [
          :role_type
        ]
      ]
    end

    # def self.permitted_object_person_params
    #   [
    #     :id,
    #     :honorific_prefix,
    #     :given_name,
    #     :family_name,
    #     :_destroy
    #   ]
    # end

    def self.build_permitted_params
      permitted = super
      # add in object_date attributes
      permitted << { object_dates_attributes: permitted_object_date_params }
      permitted << { object_person_attributes: permitted_object_person_nested }
      permitted
    end
  end
end
