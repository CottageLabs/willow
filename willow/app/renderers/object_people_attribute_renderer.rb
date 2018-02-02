class ObjectPeopleAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  include Concerns::CssTableRenderer

  def i18n_prefix
    'rdss.people.'
  end

  def role_types(value, converter=::Cdm::Json::ObjectPeople)
    converter.new(value).map(&:people)
  end

  def attribute_value_to_html(value)
    table {
      thead {
        people(value).map do |v|
          row {
            header { I18n.t(i18n_prefix + v.to_s) }
          }
        end.join
      }
    }
  end
end