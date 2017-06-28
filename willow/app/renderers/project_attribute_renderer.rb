class ProjectAttributeRenderer < CurationConcerns::Renderers::FacetedAttributeRenderer
  private
  def li_value(value)
    value = JSON.parse(value)
    html = []
    value.each do |v|
      project = []
      if v.include?('title') and not v['title'].blank?
        project << "#{v['title'][0]}"
      end
      if v.include?('identifier') and not v['identifier'].blank?
        project << "identifier: #{v['identifier'][0]}"
      end
      if v.include?('funder_name') and not v['funder_name'].blank?
        project << link_to(ERB::Util.h(v['funder_name'][0]), search_path(v['funder_name'][0]))
      end
      if v.include?('funder_id') and not v['funder_id'].blank?
        project << "Funder Id: #{v['funder_id'][0]}"
      end
      if v.include?('grant_number') and not v['grant_number'].blank?
        project << "Grant number: #{v['grant_number'][0]}"
      end
      html << project.join('<br>')
    end
    html = html.join('<br/><br/>')
    %(#{html})
  end
end
