class AgentIndexer < ActiveFedora::IndexingService
  include Hyrax::IndexesThumbnails

  self.thumbnail_path_service = Hyrax::WorkThumbnailPathService

  included Hyrax::IndexesBasicMetadata do
    self.stored_and_facetable_fields = []
    self.stored_fields = []
    self.symbol_fields = []
  end

  # Custom indexing behavior
  def generate_solr_document
    super.tap do |solr_doc|
      # basic fields
      # Solrizer.set_field(solr_doc, 'generic_type', object.human_readable_type, :facetable)
      solr_doc['visibility_ssi'] = object.visibility
      # identifier
      solr_doc[Solrizer.solr_name('identifier_nested', :symbol)] = object.identifier_nested.map { |i| i.obj_id.first }
      unless object.identifier_nested.blank?
        solr_doc[Solrizer.solr_name('identifier_nested', :displayable)] = object.identifier_nested.to_json
      end
      object.identifier_nested.each do |i|
        unless (i.obj_id_scheme.first.blank? or i.obj_id.first.blank?)
          solr_doc[Solrizer.solr_name("identifier_#{i.obj_id_scheme.first.downcase}", :symbol)] = i.obj_id.reject(&:blank?)
        end
      end
      # contact
      solr_doc[Solrizer.solr_name('contact_email', :stored_searchable)] = object.contact_nested.map { |i| i.email.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('contact_address', :stored_searchable)] = object.contact_nested.map { |i| i.address.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('contact_telephone', :symbol)] = object.contact_nested.map { |i| i.telephone.first }.reject(&:blank?)
      unless object.contact_nested.blank?
        solr_doc[Solrizer.solr_name('contact_nested', :displayable)] = object.contact_nested.to_json
      end
      # organisation
      if object.human_readable_type == 'Person' and not object.organisations.blank?
        solr_doc[Solrizer.solr_name('organisation', :stored_searchable)] = object.organisations.map { |o| o.org_name.first }.reject(&:blank?)
        orgs = []
        object.organisations.each do |o|
          orgs << {org_name: o.org_name, org_type: o.org_type, id: o.id}
        end
        solr_doc[Solrizer.solr_name('organisation', :displayable)] = orgs.to_json
      end
    end
  end
end
