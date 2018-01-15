module Solr
  module Concerns
    module IndexTypes
      extend ActiveSupport::Concern

      included do
        [:stored_searchable, :displayable, :facetable].each do |index_type|
          define_singleton_method(index_type) do |*names|
            names.each do |name|
              #use the instance solr_name definition defined in this file unless overridden
              define_method name do
                solr_name(name, index_type)
              end
            end
          end

          #Uses the class solr_name definition as defined in Hydra::Controller::ControllerBehaviour and possibly others
          define_singleton_method(index_type.to_s+'_name') do |name|
            solr_name(name, index_type)
          end
        end
      end

      def solr_name(name, index_type)
        self[Solrizer.solr_name(name, index_type)]
      end

    end
  end
end