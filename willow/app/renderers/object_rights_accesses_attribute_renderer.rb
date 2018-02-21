class ObjectRightsAccessesAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  include Concerns::CssTableRenderer

  def accesses(value)
    json = [JSON.parse(value)].flatten # make sure we get an array, even if the json is just a single value
    json.map{|x| ::Cdm::Json::Access.new(x) unless x.empty?}.compact # reject any rows that are empty
  end

  public
  def attribute_value_to_html(value)
    table {
      thead {
        row { header { "Access type" } + header { "Access Statement" } }
      } +
      tbody {
        accesses(value).map do |access|
          row {
            cell { I18n.t("rdss.access_types.#{access.type}", default: access.type)} +
            cell { access.statement }
          }
        end.join
      }
    }
  end
end
