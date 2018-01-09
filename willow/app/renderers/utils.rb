# Common methods to humanize attributes in Renderers
# Uses I18n when available, otherwise falls back to
# manipulation of original attribute value
module Utils
  private

  def humanized(value)
    value = underscored(value)
    I18n.t(value, default: value.titlecase)
  end

  def underscored(value)
    value.to_s.underscore
  end
end
