class HumanizedNestedCreatorAttributeRenderer < Hyrax::Renderers::FacetedAttributeRenderer
  include Utils

  private

  def li_value(values)
    html = []
    JSON.parse(values).each do |v|
      creator = []
      creator << creator_link(v)
      creator << affiliation(v) if affiliation(v)
      creator << orcid(v) if orcid(v)
      creator << role(v) if role(v)
      html << creator.join('<br>')
    end
    html.join('<br/><br/>').to_s
  end

  def affiliation(v)
    return unless v.include?('affiliation') && v['affiliation'][0].present?
    "Affiliation: #{humanized(v['affiliation'][0])}"
  end

  def creator_link(v)
    name = creator_name(v) || compound_name(v)
    link_to(ERB::Util.h(name), search_path(name))
  end

  def creator_name(v)
    humanized(v['name'][0]) if v.include?('name') && v['name'][0].present?
  end

  def compound_name(v)
    name = []
    name = v['first_name'] if v.include?('first_name') && ['first_name'].present?
    name << v['last_name'] if v.include?('last_name') && v['last_name'].present?
    name.join(' ').strip
  end

  def orcid(v)
    return unless v.include?('orcid') && v['orcid'][0].present?
    "Orcid: #{humanized(v['orcid'][0])}"
  end

  def role(v)
    return unless v.include?('role') && v['role'][0].present?
    "Role: #{humanized(v['role'][0])}"
  end
end
