# Generated via
#  `rails generate hyrax:work RdssDataset`
module Hyrax
  class RdssDatasetForm < Hyrax::Forms::WorkForm
    self.model_class = ::RdssDataset
    self.terms += [:creator_nested, :resource_type, :category, :identifier_nested,
      :date, :rights_holder, :license_nested, :relation, :organisation_nested, :rating]
    self.terms -= [:based_near, :creator, :contributor, :date_created,
      :identifier, :language, :license, :related_url, :publisher, :subject]
    self.required_fields += [:creator_nested, :date, :resource_type, :license_nested]
    self.required_fields -= [:creator, :keyword, :license]

    NESTED_ASSOCIATIONS = [:date, :creator_nested, :license_nested, :relation,
      :identifier_nested, :organisation_nested].freeze

    protected

      def self.permitted_date_params
        [:id,
         :_destroy,
         {
           date: [],
           description: []
         },
        ]
      end

      def self.permitted_relation_params
        [:id,
         :_destroy,
         {
           label: [],
           url: [],
           identifier: [],
           identifier_scheme: [],
           relationship_name: [],
           relationship_role: []
         },
        ]
      end

      def self.permitted_license_params
        [:id,
         :_destroy,
         {
           label: [],
           definition: [],
           webpage: [],
           start_date: []
         },
        ]
      end

      def self.permitted_creator_params
        [:id,
         :_destroy,
         {
           name: [],
           orcid: [],
           role: []
         },
        ]
      end

      def self.permitted_identifier_params
        [:id,
         :_destroy,
         {
           obj_id_scheme: [],
           obj_id: []
         },
        ]
      end

      def self.permitted_organisation_params
        [:id,
         :_destroy,
         {
           name: [],
           role: [],
           identifier: []
         },
        ]
      end

      def self.build_permitted_params
        permitted = super
        permitted << { date_attributes: permitted_date_params }
        permitted << { relation_attributes: permitted_relation_params }
        permitted << { license_nested_attributes: permitted_license_params }
        permitted << { creator_nested_attributes: permitted_creator_params }
        permitted << { identifier_nested_attributes: permitted_identifier_params }
        permitted << { organisation_nested_attributes: permitted_org_params }
        permitted
      end
  end
end
