def load_default_workflow
  # allows all registered users to deposit with default workflow
  Hyrax::PermissionTemplateAccess.where(agent_type: "group", agent_id: "registered", access: "deposit").first_or_create!(
      permission_template: Hyrax::PermissionTemplate.where(source_id: AdminSet.first.id).first_or_initialize)

  Hyrax::Workflow::WorkflowImporter.load_workflows

  Sipity::Workflow.where(name: "default").first.update!(active: true)
end
