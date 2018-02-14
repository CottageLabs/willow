class ObjectRelatedIdentifiersAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  include Concerns::CssTableRenderer

  def related_identifiers(value)
    json = JSON.parse(value)
    json = [json] unless json.is_a? Array  # make sure we get an array, even if the json is just a single value
    json.map{|x| ::Cdm::Json::RelatedIdentifier.new(x) unless x.empty?}.compact # reject any rows that are empty
  end

  def attribute_value_to_html(value)
    table {
      thead {
        row { header { "Relation" } + header { "Type" } + header { "Value" } }
      } + 
      tbody {
        related_identifiers(value).map do |ri|
          row {
            cell { I18n.t("rdss.relation_types.#{ri.relation_type}", default: ri.relation_type) if ri.relation_type} + 
            cell { I18n.t("rdss.identifier_types.#{ri.identifier_type}", default: ri.identifier_type) if ri.identifier_type} + 
            cell { ri.identifier_value }
          }
        end.join
      }
    }
  end
end
