module Hyrax
  class Institution
    def self.name
      I18n.t('hyrax.institution_name', institution_name: ENV["INSTITUTION_NAME"])
    end

    def self.name_full
      I18n.t('hyrax.institution_name_full', institution_name_full: ENV["INSTITUTION_NAME_FULL"], default: name)
    end
  end
end
