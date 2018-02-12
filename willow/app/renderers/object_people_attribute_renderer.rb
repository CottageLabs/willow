class ObjectPeopleAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  include Concerns::CssTableRenderer

  def people(value, converter=::Cdm::Json::ObjectPeople)
    converter.new(value)
  end

  def render_roles(person)
    person.roles.map{ |role| row { cell { role.name } } }.join
  end

  public
  def attribute_value_to_html(value)
    table {
      people(value).map do |person|
        row {
          cell { person.name } +
          cell {
            table {
              tbody {
                render_roles(person)
              }
            }
          }
        }
      end.join
    }
  end
end