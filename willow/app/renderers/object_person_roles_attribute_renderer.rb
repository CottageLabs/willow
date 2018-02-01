class ObjectPersonRolesAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  include Concerns::CssTableRenderer

  def i18n_prefix
    'rdss.person_roles.'
  end

  def role_types(value, converter=::Cdm::Json::ObjectPersonRoles)
    converter.new(value).map(&:role_type)
  end

  def attribute_value_to_html(value)
    table {
      thead {
        role_types(value).map do |v|
          row {
            header { I18n.t(i18n_prefix + v.to_s) }
          }
        end.join
      }
    }
  end
end