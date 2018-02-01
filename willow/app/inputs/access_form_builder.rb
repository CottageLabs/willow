class AccessFormBuilder < RdssFields

  def access_type
    input :access_type, collection: Cdm::AccessTypesService.select_all_options, prompt: :translate, required: true
  end

  def access_statement
    input :access_statement
  end
end