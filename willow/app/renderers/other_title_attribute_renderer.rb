# app/renderers/email_attribute_renderer.rb
class OtherTitleAttributeRenderer < CurationConcerns::Renderers::RightsAttributeRenderer
  private
  def attribute_value_to_html(value)
    value = JSON.parse(value)
    if not value.kind_of?(Array)
      value = [value]
    end
    html = '<table class="table"><tbodby>'
    value.each do |v|
      label = ''
      val = ''
      if v.include?('title_type') and not v['title_type'].blank? and not v['title_type'][0].blank?
        label = TitleTypesService.label(v['title_type'][0])
      end
      if v.include?('title') and not v['title'].blank? and not v['title'][0].blank?
        val = v['title'][0]
      end
      html += "<tr><th>#{label}</th><td>#{val}</td></tr>"
    end
    html += '</tbody></table>'
    %(#{html})
  end
end
