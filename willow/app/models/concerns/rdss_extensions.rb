module Concerns
  module RdssExtensions
    extend ActiveSupport::Concern

    class_methods do
      def stored_searchable(*names)
        names.each do |name|
          define_method name do
            solr_name(name, :stored_searchable)
          end
        end
      end

      def displayable(*names)
        names.each do |name|
          define_method name do
            solr_name(name, :displayable)
          end
        end
      end
    end

    included do
      stored_searchable :doi, :coverage, :apc, :tagged_version, :category, :rating, :rights_holder, :rdss_version
      displayable :other_title, :creator_nested, :date, :license_nested, :relation, :subject_nested, :admin_metadata
      displayable :project, :identifier_nested, :organisation_nested, :preservation_nested

      #New RDSS CSM types
      stored_searchable :title, :object_description, :object_keywords, :object_category, :object_person_role
    end

    def solr_name(name, type)
      self[Solrizer.solr_name(name, type)]
    end
  end
end
