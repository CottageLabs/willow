class ObjectOrganisationFormBuilder < RdssFields
  def jisc_id
    input :jisc_id
  end

  def name
    input :name
  end

  def address
    input :address, as: :text
  end

  def organisation_type(required: true)
    input :organisation_type,
          collection: ::Cdm::ObjectOrganisationTypesService.select_all_options,
          prompt: :translate,
          required: required
  end
end
