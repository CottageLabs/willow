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

        def add_labelled_facet_field(config, name, options={limit: 5})
          config.add_facet_field(facetable_name(name), default_label_options(name).merge(options))
        end

        def add_labelled_index_field(config, name, options={})
          name, label_name, index_type, options = if name.is_a?(Hash)
                                        decode_name_and_options(name, options)
                                      else
                                        [name, name, :stored_searchable, :options]
                                      end

          end
          config.add_facet_field(stored_searchable_name(name), default_label_options(name).merge(options))
        end

        def add_labelled_show_field(config, name, options={})
          config.add_show_field(stored_searchable_name(name), default_label_options(name).merge(options))
        end

        def add_facet_field(config, *names)
          names.each {|name| add_labelled_facet_field(config, name)}
        end

        def add_index_field(config, *names)
          names.each {|name| add_labelled_index_field(config, name, default_index_options(name))}
        end

        def add_show_field(config, *names)
          names.each {|name| add_labelled_show_field(config, name)}
        end

        def to_searchable_names_field_list(*names)
          names.map {|name| stored_searchable_name(name)}.join(' ')
        end
      end

    end
  end
end