class ObjectRelatedIdentifierFormBuilder < RdssFields
  def relation_type(required: false)
    input :relation_type, collection: Cdm::RelationTypesService.select_all_options, prompt: :translate, label: false, required: required
  end

  def identifier
    object.build_identifier if object.identifier.blank?
  end
end