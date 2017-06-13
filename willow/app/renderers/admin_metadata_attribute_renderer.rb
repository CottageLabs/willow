# app/renderers/email_attribute_renderer.rb
class AdminMetadataAttributeRenderer < CurationConcerns::Renderers::AttributeRenderer
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
      if v.include?('question') and not v['question'].blank?
        label = v['question'][0]
      end
      if v.include?('response') and not v['response'].blank?
        val = v['response'][0]
      end
      html += "<tr><th>#{label}</th><td>#{val}</td></tr>"
    end
    html += '</tbody></table>'
    %(#{html})
  end
end
