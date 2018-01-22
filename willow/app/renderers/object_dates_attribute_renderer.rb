class ObjectDatesAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  # translate the json string for object date into a table of displayable dates
  # parse the json, and create a table where each row has a cell with the date type and the date value
  def attribute_value_to_html(value)
    value = JSON.parse(value)
    if not value.kind_of?(Array)
      value = [value]
    end
    html = '<table class="table"><tbody>'
    value.each do |v|
      label = ''
      val = ''
      if(type = v['date_type'])
        label = RdssDateTypesService.label(type)
      end
      if(date = v['date_value'])
        begin
          val = Date.parse(date).to_formatted_s(:standard)
        rescue
          val = date
        end
      end
      html += "<tr><th>#{label}</th><td>#{val}</td><tr>"
    end
    html += '</tbody></table>'
    %(#{html})
  end
end