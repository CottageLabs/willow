SimpleForm.setup do |config|
  # Set up a wrapper to only output the label and help text, without the input
  # this is used by nested properties where the label for the model as a whole is desired
  # but finer control is needed over the inputs and layout
  # Note: this is replacing the functionality in https://github.com/samvera/hydra-editor/blob/master/app/inputs/multi_value_input.rb
  config.wrappers :label_and_hint_only do |b|
    b.use :html5
    b.use :label, class: 'control-label'
    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    #b.use :input # note we don't include the input
  end

end