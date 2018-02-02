class ObjectPersonFormBuilder < RdssFields
  def honorific_pre
    input :honorific_pre, label: false, required: object.required?(:honorific_pre)
  end

  def given_name
    input :given_name, label: false, required: object.required?(:given_name)
  end

  def family_name
    input :family_name, label: false, required: object.required?(:family_name)
  end

  def destroy
    input :_destroy, as: :hidden, input_html:{ data: { destroy: true }, class: 'form-control remove-hidden', value: false}
  end
end