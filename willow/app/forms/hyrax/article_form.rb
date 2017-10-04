# Generated via
#  `rails generate hyrax:work Article`
module Hyrax
  class ArticleForm < Hyrax::Forms::WorkForm
    self.model_class = ::Article
    self.terms -= [
      # Fields not interested in
      :based_near, :creator, :contributor, :date_created, :identifier,
      :license, :related_url, :subject,
      # Fields interested in, but removing to re-order
      :title, :description, :keyword, :language, :publisher, :rights_statement,
      :source
     ]

    self.terms += [:title, :creator_nested, :resource_type, :rights_statement,
      :license_nested, :publisher, :date, :description, :doi, :identifier_nested,
      :keyword, :subject_nested, :language, :coverage, :apc, :tagged_version, 
      :relation, :project, :source, :admin_metadata]

    self.required_fields -= [
      # Fields not interested in
      :creator, :keyword,
      # Fields interested in, but removing to re-order
      :title, :rights_statement]

    self.required_fields += [:title, :creator_nested, :resource_type,
      :rights_statement, :license_nested, :publisher, :date]

    NESTED_ASSOCIATIONS = [:date, :creator_nested, :license_nested,
      :subject_nested, :relation, :admin_metadata, :project, :identifier_nested].freeze

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

      def self.permitted_admin_params
        [:id,
         :_destroy,
         {
           question: [],
           response: []
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

      def self.permitted_project_params
        [:id,
         :_destroy,
         {
           identifier: [],
           title: [],
           funder_name: [],
           funder_id: [],
           grant_number: []
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
        permitted << { date_attributes: permitted_date_params }
        permitted << { relation_attributes: permitted_relation_params }
        permitted << { admin_metadata_attributes: permitted_admin_params }
        permitted << { license_nested_attributes: permitted_license_params }
        permitted << { creator_nested_attributes: permitted_creator_params }
        permitted << { subject_nested_attributes: permitted_subject_params }
        permitted << { project_attributes: permitted_project_params }
        permitted << { identifier_nested_attributes: permitted_identifier_params }
        permitted
      end

  end
end
