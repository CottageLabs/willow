class ObjectPersonRoleFormBuilder < RdssFields
  def role_type(required: false)
    input :role_type, collection: ::Cdm::ObjectPersonRolesService.select_all_options, prompt: :translate, label: false, required: required
  end
end