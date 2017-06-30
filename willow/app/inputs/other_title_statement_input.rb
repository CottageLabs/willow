class OtherTitleStatementInput < NestedAttributesInput

protected

  def build_components(attribute_name, value, index, options)
    out = ''

    other_title_statement = value

    # --- title_type and title - single row
    out << "<div class='row'>"

    # --- title_type
    field = :title_type
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = other_title_statement.send(field).first

    out << "  <div class='col-md-3'>"
    out << template.select_tag(field_name, template.options_for_select(TitleTypesService.select_all_options, field_value),
        label: '', class: 'select form-control', prompt: 'choose type', id: field_id)
    out << '  </div>'

    # --- title
    field = :title
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = other_title_statement.send(field).first

    out << "  <div class='col-md-6'>"
    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id))
    out << '  </div>'

    # --- delete checkbox
    out << "  <div class='col-md-3'>"
    out << destroy_widget(attribute_name, index)
    out << '  </div>'

    out << '</div>' # last row
    out
  end
end
