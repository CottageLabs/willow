class RightsStatementInput < NestedAttributesInput

  protected

    # The markup here is also duplicated in app/assets/javascripts/templates/editor/rights_statement.hbs
    # Any changes to this markup should also be reflected there as well
    def build_components(attribute_name, value, index, options)
      out = ''

      rights_statement = value

      # --- label
      field = :label
      field_name = name_for(attribute_name, index, field)
      field_value = rights_statement.send(field).first

      out << "<div class='row'>"
      out << "  <div class='col-md-3'>"
      out << template.label_tag(field_name, field.to_s.humanize, required: false)
      out << '  </div>'

      out << "  <div class='col-md-6'>"
      out << template.select_tag(field_name, template.options_for_select(rights_statement_qualifier_options, field_value), include_blank: true, label: '', class: 'select form-control')
      out << '  </div>'
      out << '</div>' # row

      # --- Definition
      field = :definition
      field_name = name_for(attribute_name, index, field)
      field_value = rights_statement.send(field).first

      out << "<div class='row'>"
      out << "  <div class='col-md-3'>"
      out << template.label_tag(field_name, field.to_s.humanize, required: false)
      out << '  </div>'

      out << "  <div class='col-md-6'>"
      out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name))
      out << '  </div>'
      out << '</div>' # row

      # last row
      out << "<div class='row'>"

      # --- webpage
      field = :webpage
      field_value = rights_statement.send(field).first
      field_name = name_for(attribute_name, index, field)

      out << "  <div class='col-md-3'>"
      out << template.label_tag(field_name, field.to_s.humanize, required: false)
      out << '  </div>'

      out << "  <div class='col-md-6'>"
      out << @builder.text_field(field_name, options.merge(value: field_value, name: field_name))
      out << '  </div>'

      # delete checkbox
      if !value.new_record?
        out << "  <div class='col-md-3'>"
        out << destroy_widget(attribute_name, index)
        out << '  </div>'
      end

      out << '</div>' # last row
      out
    end

    def rights_statement_qualifier_options
      RightsStatement.qualifiers.map { |q| [q, q] }
    end
end
