class ObjectPeopleAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  include Concerns::CssTableRenderer

  def i18n_prefix
    'rdss.'
  end

  def people(value, converter=::Cdm::Json::ObjectPeople)
    converter.new(value)
  end

  def attribute_value_to_html(value)
    table {
      thead {
        row {
          header { I18n.t(i18n_prefix + 'people') } +
          header { I18n.t(i18n_prefix + 'person_roles') }
        }
        people(value).map do |v|
          row {
            cell { v.name } +
            cell {
              table {
                tbody {
                  v.roles.map do |r|
                    row {
                      cell { r.name }
                    }
                  end.join
                }
              }
            }
          }
        end.join
      }
    }
  end
end