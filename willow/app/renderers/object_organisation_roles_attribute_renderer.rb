class ObjectOrganisationRolesAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private

  include Concerns::CssTableRenderer

  def converter
    @converter ||= ::Cdm::Json::ObjectOrganisationRoles
  end

  def i18n_prefix
    'rdss.organisation_roles.'
  end

  def organisation(value)
    converter.new(value).roles[0].organisation
  end

  def organisation_renderer
    ObjectOrganisationAttributeRenderer.new
  end

  def render_organisation(value)
    organisation_renderer.render(organisation(value))
  end

  def roles(value)
    converter.new(value)
  end

  def attribute_value_to_html(value)
    table do
      thead do
        roles(value).map do |v|
          row do
            header { I18n.t("#{i18n_prefix}#{v.role}") }
          end
        end.join + render_organisation(value)
      end
    end
  end
end
