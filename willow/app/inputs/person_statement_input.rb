class PersonStatementInput < NestedAttributesInput

protected

  def build_components(attribute_name, value, index, options)
    out = ''

    person_statement = value

    # Inherit required for fields validated in nested attributes
    required  = false
    if object.required?(:creator_nested) and index == 0
      required = true
    end

    # --- first_name
    field = :first_name
    field_name = name_for(attribute_name, index, field)
    field_value = person_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-9'>"
    out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, required: required))
    out << '  </div>'
    out << '</div>' # row

    # --- last_name
    field = :last_name
    field_name = name_for(attribute_name, index, field)
    field_value = person_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-9'>"
    out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, required: required))
    out << '  </div>'
    out << '</div>' # row

    # --- orcid
    field = :orcid
    field_name = name_for(attribute_name, index, field)
    field_value = person_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-9'>"
    out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, required: required))
    out << '  </div>'
    out << '</div>' # row

    # --- affiliation
    field = :affiliation
    field_name = name_for(attribute_name, index, field)
    field_value = person_statement.send(field).first

    out << "<div class='row'>"
    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: false)
    out << '  </div>'

    out << "  <div class='col-md-9'>"
    out << @builder.text_field(field_name,
        options.merge(value: field_value, name: field_name, required: false))
    out << '  </div>'
    out << '</div>' # row

    # last row
    out << "<div class='row'>"

    # --- role
    if object.model_class == ::Dataset
        options = DatasetAgentRolesService.select_all_options
    else
        options = ArticleAgentRolesService.select_all_options
    end
    field = :role
    field_name = name_for(attribute_name, index, field)
    field_value = person_statement.send(field).first

    out << "  <div class='col-md-3'>"
    out << template.label_tag(field_name, field.to_s.humanize, required: required)
    out << '  </div>'

    out << "  <div class='col-md-9'>"
    out << template.select_tag(field_name, template.options_for_select(options, field_value),
        prompt: 'Select role played', label: '', class: 'select form-control', required: required)
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
