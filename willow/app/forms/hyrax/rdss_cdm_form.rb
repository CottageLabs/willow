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
      #:object_version,
      :object_resource_type,
      :object_value,
      :object_people,
      :object_dates,
      :object_rights,
      :object_organisation_roles,
      :object_identifiers,
      :object_related_identifiers,
    ]

    self.required_fields = [
      :title,
      :object_description,
      :object_resource_type,
      :object_value,
      :object_people,
      :object_dates,      
      :object_rights,
      :object_organisation_roles,
      :object_identifiers,
    ]

    mapped_arrays :object_dates,
                  :object_organisation_roles,
                  :object_identifiers,
                  :object_related_identifiers


    def object_people
      convert_value_to_array(model.object_people)
    end

    # utility methods to allow nested fields to work with the hyrax form
    # Taken from https://github.com/curationexperts/laevigata/

    # In the view we have "fields_for nested models.
    # For each nested_model we need to delegate the _attributes= method
    # to the model, to make fields_for behave as an
    # association and populate the form with the correct
    # object_date data.
    delegate :object_dates_attributes=,
             :object_people_attributes=,
             :object_rights_attributes=,
             :object_organisation_roles_attributes=,
             :object_identifiers_attributes=,
             :object_related_identifiers_attributes=,
             to: :model

    # for object_rights, we present the has_many relationship as a has_one
    # by only returning the first model
    def object_rights
      convert_value_to_array(model.object_rights).slice(0,1) # return an array containing only the first object_rights or an empty array
    end

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
    #     :role_type,
    #     :_destroy,
    #     [
    #       object_people_attributes: permitted_object_person_params
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
        object_person_roles_attributes: permitted_object_person_roles_params
      ]
    end

    def self.permitted_object_person_roles_params
      [
        :id,
        :role_type,
        :_destroy
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

    def self.permitted_object_rights_params
      [
        :id,
        [
          rights_statement: [],
          rights_holder: [],
          licence: [],
          accesses_attributes: [
            :id,
            :_destroy,
            [
              :access_type,
              :access_statement
            ]
          ]
        ]
      ]
    end


    def self.permitted_object_organisation_roles_params
      [
        :id,
        :role,
        :_destroy,
        organisation_attributes: %i[jisc_id name address organisation_type]
      ]
    end


    def self.permitted_object_identifier_params
      [
        :id,
        :_destroy,
        :identifier_value,
        :identifier_type
      ]
    end

    def self.permitted_object_related_identifier_params
      [
        :id,
        :_destroy,
        :relation_type,
        identifier_attributes: permitted_object_identifier_params
      ]
    end

    def self.build_permitted_params
      permitted = super
      # add in object_date attributes
      permitted << { object_dates_attributes: permitted_object_date_params }
      permitted << { object_people_attributes: permitted_object_person_nested }
      permitted << { object_rights_attributes: permitted_object_rights_params }
      permitted << { object_organisation_roles_attributes: permitted_object_organisation_roles_params }
      permitted << { object_identifiers_attributes: permitted_object_identifier_params }
      permitted << { object_related_identifiers_attributes: permitted_object_related_identifier_params }
      permitted
    end
  end
end
