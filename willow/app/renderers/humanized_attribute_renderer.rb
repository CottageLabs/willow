# Overrides the default `li_value` behaviour and outputs 
# a humanized version of the attribute value
class HumanizedAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  include Utils

  private

  def li_value(value)
    auto_link(ERB::Util.h(humanized(value)))
  end
end
