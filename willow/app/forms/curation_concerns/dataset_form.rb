# Generated via
#  `rails generate curation_concerns:work Dataset`
module CurationConcerns
  class DatasetForm < Sufia::Forms::WorkForm
    self.model_class = ::Dataset
    self.terms += [:doi, :publication_date, :other_title]
    # self.terms -= [:rights]
    self.required_fields += [:publisher, :publication_date, :resource_type]
    self.required_fields -= [:keyword,]

    NESTED_ASSOCIATIONS = [:other_title, :rights, :creator].freeze

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
