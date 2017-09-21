class NestedIdentifierAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  def attribute_value_to_html(value)
    value = JSON.parse(value)
    if not value.kind_of?(Array)
      value = [value]
    end
    html = '<table class="table"><tbody>'
    value.each do |v|
      label = ''
      val = ''
      if v.include?('obj_id_scheme') and not v['obj_id_scheme'].blank? and
        not v['obj_id_scheme'][0].blank?
        label = v['obj_id_scheme'][0]
      end
      if v.include?('obj_id') and not v['obj_id'].blank? and not v['obj_id'][0].blank?
        val = v['obj_id'][0]
      end
      html += "<tr><th>#{label}</th><td>#{val}</td></tr>"
    end
    html += '</tbody></table>'
    %(#{html})
  end
end
