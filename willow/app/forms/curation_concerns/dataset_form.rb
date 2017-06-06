# Generated via
#  `rails generate curation_concerns:work Dataset`
module CurationConcerns
  class DatasetForm < Sufia::Forms::WorkForm
    self.model_class = ::Dataset
    self.terms += [:resource_type, :doi, :other_title, :date, :relation, :admin_metadata]
    self.terms -= [:contributor, :date_created, :identifier, :based_near, :related_url]
    # self.terms -= [:rights]
    self.required_fields += [:publisher, :date, :resource_type]
    self.required_fields -= [:keyword, :rights]

    NESTED_ASSOCIATIONS = [:other_title, :date, :creator, :rights, :subject,
      :relation, :admin_metadata].freeze

    protected

      def self.permitted_other_params
        [:id,
         :_destroy,
         {
           title: [],
           title_type: [],
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

      def self.build_permitted_params
        permitted = super
        permitted << { other_title_attributes: permitted_other_params }
        permitted << { rights_attributes: permitted_rights_params }
        permitted << { creator_attributes: permitted_creator_params }
        permitted
      end

  end
end
