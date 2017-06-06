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
    field_value = other_title_statement.send(field).first

    out << "  <div class='col-md-3'>"
    out << template.select_tag(field_name, template.options_for_select(TitleTypesService.select_all_options, field_value), label: '', class: 'select form-control', prompt: 'choose type')
    out << '  </div>'

    # --- title
    field = :title
    field_name = name_for(attribute_name, index, field)
    field_value = other_title_statement.send(field).first

    out << "  <div class='col-md-9'>"
    out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name))
    out << '  </div>'

    # --- delete checkbox
    # if !value.new_record?
    #   out << "  <div class='col-md-3'>"
    #   out << destroy_widget(attribute_name, index)
    #   out << '  </div>'
    # end

    out << '</div>' # last row
    out
  end
end
