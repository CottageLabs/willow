class ObjectRightsFormBuilder < RdssFields
  def licence
    input :licence, 
      as: :multi_value_select, 
      collection: Hyrax::LicenseService.new.select_active_options, 
      input_html: {
        prompt: I18n.t('simple_form.prompts.rdss_cdm.object_rights.licence')
      },
      required: true
  end

  def rights_holder
    input :rights_holder, as: :multi_value, required: true
  end

  def rights_statement
    input :rights_statement, as: :multi_value, required: true
  end

  def accesses
    object.accesses.build if object.accesses.blank?
  end
end