module Solr
  module Concerns
    module IndexTypes
      extend ActiveSupport::Concern

      included do
        delegate :solr_name, to: ::Solrizer

        [:stored_searchable, :stored_sortable, :displayable, :facetable, :symbol].each do |index_type|
          define_singleton_method(index_type) do |*names|
            names.each do |name|
              #use the instance solr_name definition defined in this file unless overridden
              define_method name do |*options|
                solr_value(name, index_type, *options)
              end
            end
          end

          #Uses the class solr_name definition as defined in Hydra::Controller::ControllerBehaviour and possibly others
          define_singleton_method(index_type.to_s + '_name') do |name, *options|
            solr_name(name, index_type, *options)
          end
        end
      end

      def solr_value(name, *options)
        self[solr_name(name.to_s, *options)]
      end

    end
  end
end