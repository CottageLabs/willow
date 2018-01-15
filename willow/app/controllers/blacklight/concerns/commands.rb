module Blacklight
  module Concerns
    module Commands
      extend ActiveSupport::Concern
      include ::Solr::Concerns::IndexTypes

      class_methods do
        def default_label_options(name)
          {label: I18n.t('willow.fields.'+name)}
        end

        def default_index_options(name)
          {itemprop: name, link_to_search: facetable_name(name)}
        end

        def labelled_facet_field_adder(config, name, options={limit: 5})
          config.add_facet_field(facetable_name(name), default_label_options(name).merge(options))
        end

        def labelled_index_field_adder(config, name, options={})
          config.add_facet_field(stored_searchable_name(name), default_label_options(name).merge(options))
        end

        def default_labelled_index_field_adder(config, name, options={})
          labelled_index_field_adder(config, name, default_index_options(name).merge(options))
        end

        def default_facet_field_adder(config, *names)
          names.each {|name| labelled_facet_field_adder(config, name)}
        end

        def to_searchable_names_field_list(*names)
          names.map {|name| stored_searchable_name(name)}.join(' ')
        end
      end

    end
  end
end