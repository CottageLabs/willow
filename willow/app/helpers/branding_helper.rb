module BrandingHelper
  def institution_name
    I18n.t('hyrax.institution_name', institution_name: ENV["INSTITUTION_NAME"])
  end

  def institution_name_full
    I18n.t('hyrax.institution_name_full', institution_name_full: ENV["INSTITUTION_NAME_FULL"], default: institution_name)
  end
end