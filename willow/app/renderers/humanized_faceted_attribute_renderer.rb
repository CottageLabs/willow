# Overrides the default `li_value` behaviour and creates a faceted attribute
# link with a humanized value.
class HumanizedFacetedAttributeRenderer < Hyrax::Renderers::FacetedAttributeRenderer
  include Utils

  private

  def li_value(value)
    link_to(ERB::Util.h(humanized(value)), search_path(value))
  end
end
