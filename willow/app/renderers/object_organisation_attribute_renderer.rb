# Output OrganisationRole Organisation data
class ObjectOrganisationAttributeRenderer
  include Concerns::CssTableRenderer

  # rubocop:disable Layout/MultilineOperationIndentation
  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  # Outputs a CSS table from a OrganisationRole related OrganisationRole
  # object
  def render(organisation)
    table do
      thead do
        row do
          header { I18n.t('headers.rdss_cdm.jisc_id') } +
          header { I18n.t('headers.rdss_cdm.organisation_name') } +
          header { I18n.t('headers.rdss_cdm.organisation_type') } +
          header { I18n.t('headers.rdss_cdm.address') }
        end
      end +
      tbody do
        row do
          cell { organisation.jisc_id } +
          cell { organisation.name } +
          cell { type(organisation.organisation_type) } +
          cell { organisation.address }
        end
      end
    end
  end

  private

  def type(organisation_type)
    I18n.t("rdss.organisation_types.#{organisation_type.downcase}")
  end
end
