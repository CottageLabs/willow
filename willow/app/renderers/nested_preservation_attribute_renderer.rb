class NestedPreservationAttributeRenderer < Hyrax::Renderers::FacetedAttributeRenderer
  private
  def li_value(value)
    value = JSON.parse(value)
    html = []
    value.each do |v|
      event = []
      if v.include?('name') and not v['name'][0].blank?
        event << link_to(ERB::Util.h(v['name'][0]), search_path(v['name'][0]))
      end
      if v.include?('event_type') and not v['event_type'].blank? and not v['event_type'][0].blank?
        event << "Event type: #{v['event_type'][0]}"
      end
      if v.include?('date') and not v['date'].blank? and not v['date'][0].blank?
        event << "Date: #{v['date'][0]}"
      end
      if v.include?('description') and not v['description'].blank? and not v['description'][0].blank?
        event << "Description: #{v['description'][0]}"
      end
      if v.include?('outcome') and not v['outcome'].blank? and not v['outcome'][0].blank?
        event << "Outcome: #{v['outcome'][0]}"
      end
      html << event.join('<br>')
    end
    html = html.join('<br/><br/>')
    %(#{html})
  end
end
