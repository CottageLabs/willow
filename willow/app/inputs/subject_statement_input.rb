class SubjectStatementInput < NestedAttributesInput

protected

  def build_components(attribute_name, value, index, options)
    out = ''

    subject_statement = value

    # Inherit required for fields validated in nested attributes
    required  = false
    if object.required?(:subject_nested) and index == 0
      required = true
    end

    # single row
    out << "<div class='row'>"
    # --- label
    field = :label
    field_name = name_for(attribute_name, index, field)
    field_value = subject_statement.send(field).first

    out << "  <div class='col-md-12'>"
    out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name, required: required))
    out << '  </div>'

    # --- delete checkbox
    # if !value.new_record?
    #   out << "  <div class='col-md-3'>"
    #   out << destroy_widget(attribute_name, index)
    #   out << '  </div>'
    # end

    out << '</div>' # row
    out
  end

end
