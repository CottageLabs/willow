class ObjectOrganisationRolesAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private

  include Concerns::CssTableRenderer
  include Concerns::CssListRenderer

  def i18n_prefix
    'rdss.organisation_roles.'
  end

  def render_organisation(organisation)
    organisation_renderer.attribute_value_to_html(organisation)
  end

  def roles(value, converter = ::Cdm::Json::ObjectOrganisationRoles)
    converter.new(value)
  end

  def attribute_value_to_html(value)
    table do
      thead do
        roles(value).map do |v|
          row do
            header { I18n.t("#{i18n_prefix}#{v.role}") }
          end
        end.join
      end
    end
  end
end
