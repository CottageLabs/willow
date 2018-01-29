class RdssCdmPersonStatementInput < NestedAttributesInput
  def label_prefix
    'simple_form.labels.rdss_cdm'
  end

  def build_name(attribute_name, value, index, required, options)
    build_text_section( :name,
                        attribute_name,
                        value,
                        index,
                        required,
                        options
    )
  end

  def build_orcid(attribute_name, value, index, required, options)
    build_text_section( :orcid,
                        attribute_name,
                        value,
                        index,
                        required,
                        options
    )
  end

  def build_role(attribute_name, value, index, required, options)
    build_select_section( :object_person_roles,
                          attribute_name,
                          value,
                          index,
                          required,
                          :creator,
                          ::RdssPersonRolesService.select_all_options,
                          options.merge({prompt: 'Select roles played', label: '', class: 'select form-control', multiple: true})
    )
  end

  protected
  def build_components(attribute_name, value, index, options)
    required = object.required?(:creator_nested) and index == 0
    build_name(attribute_name, value, index, required, options) +
    build_orcid(attribute_name, value, index, required && object.orcid_required?, options) +
    build_role(attribute_name, value, index, required, options)
  end
end
