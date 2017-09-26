module Hyrax
  class Institution
    def self.name
      I18n.t('hyrax.institution_name', institution_name: Willow::Config.institution_name)
    end

    def self.name_full
      I18n.t('hyrax.institution_name_full', institution_name_full: Willow::Config.institution_name_full, default: name)
    end
  end
end
