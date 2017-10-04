class ObjectIdentifierInput < NestedAttributesInput

protected

  def build_components(attribute_name, value, index, options)
    out = ''

    id_statement = value

    # Inherit required for fields validated in nested attributes
    required  = false
    if object.required?(:identifier_nested) and index == 0
      required = true
    end

    # --- scheme and id - single row
    out << "<div class='row'>"

    # --- obj_id_scheme
    field = :obj_id_scheme
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = id_statement.send(field).first
    id_options = RdssIdentifierTypesService.select_all_options

    out << "  <div class='col-md-3'>"
    out << template.select_tag(field_name,
        template.options_for_select(id_options, field_value),
        label: '', class: 'select form-control', prompt: 'choose type', id: field_id)
    out << '  </div>'

    # --- obj_id
    field = :obj_id
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = id_statement.send(field).first

    out << "  <div class='col-md-6'>"
    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id,
            required: required))
    out << '  </div>'

    # --- delete checkbox
    field_label = 'Identifiers'
    out << "  <div class='col-md-3'>"
    out << destroy_widget(attribute_name, index, field_label)
    out << '  </div>'

    out << '</div>' # last row
    out
  end
end
