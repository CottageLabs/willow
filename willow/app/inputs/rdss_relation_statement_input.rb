class RdssRelationStatementInput < NestedAttributesInput

protected

  def build_components(attribute_name, value, index, options)
    out = ''

    relation_statement = value

    # Inherit required for fields validated in nested attributes
    required  = false
    if object.required?(:relation) and index == 0
      required = true
    end

    # --- title
    field = :label
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = relation_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, 'Title', required: required)
    out << '  </div>'

    out << "  <div class='col-md-9'>"
    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id, required: required))
    out << '  </div>'
    out << '</div>' # row

    # --- identifier scheme and identifier
    out << "<div class='row'>"

    # identifier scheme
    field = :identifier_scheme
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = relation_statement.send(field).first
    id_scheme_options = RdssIdentifierTypesService.select_all_options

    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, 'Identifier', required: required)
    out << '  </div>'

    out << "  <div class='col-md-3'>"
    out << template.select_tag(field_name,
        template.options_for_select(id_scheme_options, field_value),
        label: '', class: 'select form-control', prompt: 'choose type',
        id: field_id, required: required)
    out << '  </div>'

    # identifier
    field = :identifier
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = relation_statement.send(field).first

    out << "  <div class='col-md-6'>"
    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, id: field_id,
            required: required, prompt: 'Identifier value'))
    out << '  </div>'

    out << '</div>' # row

    # last row
    out << "<div class='row'>"

    # --- relationship_role
    field = :relationship_role
    field_name = name_for(attribute_name, index, field)
    field_id = id_for(attribute_name, index, field)
    field_value = relation_statement.send(field).first
    role_options = RdssRelationTypesService.select_all_options

    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, 'Relationship', required: required)
    out << '  </div>'

    out << "  <div class='col-md-6'>"
    out << template.select_tag(field_name,
        template.options_for_select(role_options, field_value),
        label: '', class: 'select form-control', prompt: 'choose relationship',
        id: field_id, required: required)
    out << '  </div>'

    # --- delete checkbox
    field_label ='Related work'
    out << "  <div class='col-md-3'>"
    out << destroy_widget(attribute_name, index, field_label)
    out << '  </div>'

    out << '</div>' # last row
    out
  end
end
