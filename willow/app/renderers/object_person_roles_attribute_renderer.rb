class ObjectPersonRolesAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  def i18n_prefix
    'rdss.person_roles.'
  end

  def attribute_value_to_html(value)
    role_types=::Cdm::Json::ObjectPersonRoles.new(value).map(&:role_type)
    html = '<div class="table"><div class="tbody">'
    role_types.each do |v|
      html << '<div class="tr"><div class="th">'+I18n.t(i18n_prefix + v.to_s)+'</div></div>'
    end
    html << '</div></div>'
    %(#{html})
  end
end