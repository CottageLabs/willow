class AccessFormBuilder < RdssFields

  def access_type
    input :access_type, collection: ::RdssAccessTypesService.select_all_options, prompt: :translate, required: true
  end

  def access_statement
    input :access_statement
  end
end