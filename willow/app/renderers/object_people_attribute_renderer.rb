class ObjectPeopleAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  include Concerns::CssTableRenderer

  def people(value, converter=::Cdm::Json::ObjectPeople)
    converter.new(value)
  end

  def render_roles(person)
    person.roles.map(&:name).join(', ')
  end

  public
  def attribute_value_to_html(value)
    table do
      thead do
        row do
          header { I18n.t('headers.rdss_cdm.person_name') } +
          header { I18n.t('headers.rdss_cdm.person_email') } +
          header { I18n.t('headers.rdss_cdm.person_roles') }
        end
      end +
      tbody do
        people(value).map do |person|
          row do
            cell { person.name } +
            cell { person.mail } +
            cell { render_roles(person) }
          end
        end.join
      end
    end
  end
end