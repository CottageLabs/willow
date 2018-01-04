# Overrides the default `li_value` behaviour and creates a faceted attribute
# link with a humanized value. Uses I18n when available, otherwise falls back to
# manipulation of original attribute value
class HumanizedFacetedAttributeRenderer < Hyrax::Renderers::FacetedAttributeRenderer
  private

  def underscored(value)
    value.to_s.underscore
  end

  def humanized(value)
    value = underscored(value)
    I18n.t(value, default: value.titlecase)
  end

  def li_value(value)
    link_to(ERB::Util.h(humanized(value)), search_path(value))
  end
end
