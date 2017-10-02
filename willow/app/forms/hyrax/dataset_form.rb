# Generated via
#  `rails generate hyrax:work Dataset`
module Hyrax
  class DatasetForm < Hyrax::Forms::WorkForm
    self.model_class = ::Dataset
    self.terms += [:creator_nested, :resource_type, :other_title, :doi, :identifier_nested,
       :date, :rights_nested, :subject_nested, :relation, :admin_metadata]
    self.terms -= [:based_near, :creator, :contributor, :date_created,
      :identifier,  :license, :related_url, :subject]
    self.required_fields += [:creator_nested, :publisher, :date, :resource_type, :rights_nested]
    self.required_fields -= [:creator, :keyword, :license, :rights_statement]

    NESTED_ASSOCIATIONS = [:other_title, :date, :creator_nested, :rights_nested,
      :subject_nested, :relation, :admin_metadata, :identifier_nested].freeze

    protected

      def self.permitted_other_params
        [:id,
         :_destroy,
         {
           title: [],
           title_type: []
         },
        ]
      end

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

      def self.permitted_admin_params
        [:id,
         :_destroy,
         {
           question: [],
           response: []
         },
        ]
      end

      def self.permitted_rights_params
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
           first_name: [],
           last_name: [],
           orcid: [],
           role: [],
           affiliation: []
         },
        ]
      end

      def self.permitted_subject_params
        [:id,
         :_destroy,
         {
           label: [],
           definition: [],
           classification: [],
           homepage: []
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

      def self.build_permitted_params
        permitted = super
        permitted << { other_title_attributes: permitted_other_params }
        permitted << { date_attributes: permitted_date_params }
        permitted << { relation_attributes: permitted_relation_params }
        permitted << { admin_metadata_attributes: permitted_admin_params }
        permitted << { rights_nested_attributes: permitted_rights_params }
        permitted << { creator_nested_attributes: permitted_creator_params }
        permitted << { subject_nested_attributes: permitted_subject_params }
        permitted << { identifier_nested_attributes: permitted_identifier_params }
        permitted
      end

  end
end
