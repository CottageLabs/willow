class ObjectOrganisationRolesAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  include Concerns::CssTableRenderer

  def i18n_prefix
    'rdss.organisation_roles.'
  end

  def roles(value, converter=::Cdm::Json::ObjectOrganisationRoles)
    converter.new(value).map(&:role)
  end

  def attribute_value_to_html(value)
    table {
      thead {
        roles(value).map do |v|
          row {
            header { I18n.t(i18n_prefix + v.to_s) }
          }
        end.join
      }
    }
  end
end