class RdssFields < SimpleForm::FormBuilder
  def destroy
    input :_destroy, as: :hidden, input_html:{ data: { destroy: true }, class: 'form-control remove-hidden', value: false}
  end
end