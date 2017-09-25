 # Generated via
#  `rails generate hyrax:work Article`
class AgentIndexer < ActiveFedora::RDF::IndexingService
  # TODO initializing ActiveFedora::RDF::IndexingService without an
  #      index_config is deprecated and will be removed in ActiveFedora 13.0
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
      # identifier
      solr_doc[Solrizer.solr_name('identifier_nested', :symbol)] = object.identifier_nested.map { |i| i.obj_id.first }
      solr_doc[Solrizer.solr_name('identifier_nested', :displayable)] = object.identifier_nested.to_json
      object.identifier_nested.each do |i|
        unless (i.obj_id_scheme.first.blank? or i.obj_id.first.blank?)
          solr_doc[Solrizer.solr_name("identifier_#{i.obj_id_scheme.first.downcase}", :symbol)] = i.obj_id.reject(&:blank?)
        end
      end
      # contact
      solr_doc[Solrizer.solr_name('contact_email', :stored_searchable)] = object.contact_nested.map { |i| i.email.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('contact_address', :stored_searchable)] = object.contact_nested.map { |i| i.address.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('contact_telephone', :symbol)] = object.contact_nested.map { |i| i.telephone.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('contact_nested', :displayable)] = object.contact_nested.to_json
    end
  end
end
