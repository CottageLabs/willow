class ObjectDateFormBuilder < RdssFields
  def date_type
    input :date_type, collection: ::RdssDateTypesService.select_all_options, prompt: :translate, label: false
  end

  def date_value
    input :date_value, label: false, input_html: {data: { provide: 'datepicker' }}
  end

  def destroy
    input :_destroy, as: :hidden, input_html:{ data: { destroy: true }, class: 'form-control remove-hidden', value: false}
  end
end