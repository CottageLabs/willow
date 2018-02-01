class ObjectPersonFormBuilder < RdssFields
  def given_name
    input :given_name, label: false
  end

  def family_name
    input :family_name, label: false
  end

  def destroy
    input :_destroy, as: :hidden, input_html:{ data: { destroy: true }, class: 'form-control remove-hidden', value: false}
  end
end