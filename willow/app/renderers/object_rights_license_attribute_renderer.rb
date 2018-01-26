# Overrides the default `li_value` behaviour and creates a faceted attribute
# link with a humanized value.
class ObjectRightsLicenseAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  include Utils

  private

  def li_value(value)
    label = Hyrax::LicenseService.new.label(value) unless value.blank?
    link_to(ERB::Util.h(label), value)
  end
end
