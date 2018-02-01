module RowLayouts
  private
  def field_values(attribute_name, value, index, field)
    [
      name_for(attribute_name, index, field),
      id_for(attribute_name, index, field),
      value.send(field).first
    ]
  end

  def label_prefix
    'simple_form.labels'
  end

  def class_prefix
    'col-md-'
  end

  def build_label(field_name, field, options)
    template.label_tag(field_name, I18n.t(label_prefix+'.'+field.to_s), options)
  end

  def build_text_field(field_name, options)
    @builder.text_field(field_name, options)
  end

  def build_select_field(field_name, options, html_options)
    template.select_tag(field_name, options, html_options)
  end

  def build_text_section(field, attribute_name, value, index, required, options)
    field_name, field_id, field_value=field_values(attribute_name, value, index, field)
    generate_text_row_html(
      build_label(field_name, field, {required: required}),
      build_text_field(field_name, options.merge(value: field_value, name: field_name, id: field_id, required: required))
    )
  end

  def build_select_section(field, attribute_name, value, index, required, widget_label, select_options, html_options)
    field_name, field_id, field_value=field_values(attribute_name, value, index, field)
    generate_select_row_html(
      build_label(field_name, field, {required: required}),
      build_select_field(field_name, template.options_for_select(select_options, field_value), html_options.merge(id: field_id, required: required)),
      build_delete_checkbox(attribute_name, index, I18n.t(widget_label))
    )
  end

  def html_row(&block)
    %Q(<div class='row'>#{block.call}</div>)
  end

  def content_block(html_class, &block)
    %Q(<div class=\'#{html_class}\'>#{block.call}</div>)
  end

  def one_third_cell(&block)
    content_block(:"#{class_prefix}3", &block)
  end

  def two_thirds_cell(&block)
    content_block(:"#{class_prefix}6", &block)
  end

  def full_cell(&block)
    content_block(:"#{class_prefix}9", &block)
  end

  alias_method :destroy_cell, :one_third_cell
  alias_method :label_cell, :one_third_cell
  alias_method :select_cell, :two_thirds_cell
  alias_method :text_cell, :full_cell

  def generate_text_row_html(label, content)
    html_row do
      label_cell { label } +
      text_cell { content }
    end
  end

  def generate_select_row_html(label, content, widget)
    html_row do
      label_cell { label } +
      select_cell { content } +
      destroy_cell { widget }
    end
  end

  def build_delete_checkbox(attribute_name, index, label)
    destroy_widget(attribute_name, index, label)
  end

end
