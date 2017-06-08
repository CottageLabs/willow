# app/renderers/email_attribute_renderer.rb
class RightsAttributeRenderer < CurationConcerns::Renderers::RightsAttributeRenderer
  private
  def attribute_value_to_html(value)
    value = JSON.parse(value)
    if not value.kind_of?(Array)
      value = [value]
    end
    value.each do |v|
      if v.include('webpage') and not v['webpage'][0].blank?
        rights_attribute_to_html(v['webpage'][0])
      end
    end
  end
end
