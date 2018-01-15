module Inputs
  module RowLayouts
    private
    def field_values(attribute_name, value, index, field)
      [
        name_for(attribute_name, index, field),
        id_for(attribute_name, index, field),
        value.send(field).first
      ]
    end

    def build_label(field_name, field, options)
      template.label_tag(field_name, I18n.t(field), options)
    end

    def build_text_field(field_name, options)
      @builder.text_field(field_name, options)
    end

    def build_select_field(field_name, select_options, options)
      template.select_tag(field_name, template.options_for_select(role_options, field_value),
                          prompt: 'Select roles played', label: '', class: 'select form-control', id: field_id, required: required, multiple: true)
    end

    def build_text_section(field, attribute_name, value, index, required, options)
      field_name, field_id, field_value=field_values(attribute_name, value, index, field)
      generate_text_row_html(
        build_label(field_name, field, {required: required}),
        build_text_field(field_name, options.merge(value: field_value, name: field_name, id: field_id, required: required))
      )
    end

    def build_select_section(field, attribute_name, value, index, required, widget_label select_options, html_options)
      field_name, field_id, field_value=field_values(attribute_name, value, index, field)
      generate_select_row_html(
        build_label(field_name, field, {required: required}),
        build_select_field(field_name, template.options_for_select(select_options, field_value), html_options.merge(id: field_id, required: required)),
        build_delete_checkbox(attribute_name, index, I18n.t(widget_label))
      )

    end

    def html_row(&block)
      content_for(:div, class: :row) do
        block.call
      end
    end

    def content_block(html_class, &block)
      content_for(:div, class: html_class) do
        block.call
      end
    end

    def label_cell(&block)
      content_block(:'col-md-3', &block)
    end

    def content_cell(&block)
      content_block(:'col-md-9', &block)
    end

    def select_cell(&block)
      content_block(:'col-md-6', &block)
    end

    alias_method :destroy_cell, :label_cell

    def generate_text_row_html(label, content)
      html_row do
        label_cell { label }
        content_cell { content }
      end
    end

    def generate_select_row_html(label, content, widget)
      html_row do
        label_cell { label }
        select_cell { content }
        destroy_cell { widget }
      end
    end

    def build_delete_checkbox(attribute_name, index, label)
      destroy_widget(attribute_name, index, label)
    end

  end
end