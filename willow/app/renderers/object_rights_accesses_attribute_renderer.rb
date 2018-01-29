class ObjectRightsAccessesAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  # translate the json string for object date into a table of displayable dates
  # parse the json, and create a table where each row has a cell with the date type and the date value
  def attribute_value_to_html(value)
    value = JSON.parse(value)

    if not value.kind_of?(Array)
      value = [value]
    end
    return nil if value.empty? # don't show the row if there is no value

    html = '<ul class="list-unstyled">'
    value.each do |v|
      if v['access_type']
        type = (RdssAccessTypesService.label v['access_type'] rescue v['access_type'])
      end
      html += "<li><strong>#{type}:</strong> <span>#{v['access_statement']}</span></li>"
    end
    html += '</ul>'
    %(#{html})
  end
end