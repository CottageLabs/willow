# app/renderers/email_attribute_renderer.rb
class NestedRightsAttributeRenderer < CurationConcerns::Renderers::AttributeRenderer
  private
  def attribute_value_to_html(value)
    value = JSON.parse(value)
    if not value.kind_of?(Array)
      value = [value]
    end
    html = []
    value.each do |v|
      row = []
      # extract values
      label = ''
      webpage = ''
      license = ''
      if v.include?('label') and not v['label'].blank?
        label = v['label'][0]
      end
      if v.include?('webpage') and not v['webpage'].blank?
        webpage = v['webpage'][0]
      end
      license = rights_attribute_to_html(label, webpage)
      if license
        row << license
      end
      if v.include?('start_date') and not v['start_date'].blank?
        val = Date.parse(v['start_date'][0]).to_formatted_s(:standard)
        row << "Start date: #{val}"
      end
      if v.include?('definition') and not v['definition'].blank?
        row << v['definition'][0]
      end
      html << row.join('<br>')
    end
    html = html.join('<br/><br/>')
    %(#{html})
  end

  def rights_attribute_to_html(label, value)
    begin
      parsed_uri = URI.parse(value)
    rescue
      nil
    end
    if label.blank? and !value.blank?
      label = CurationConcerns::LicenseService.new.label(value)
    end
    if parsed_uri.nil?
      "#{ERB::Util.h(label)}"
    else
      "<a href=#{ERB::Util.h(value)} target=\"_blank\">#{label}</a>"
    end
  end
end
