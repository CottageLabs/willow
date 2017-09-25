class GrantIndexer < ActiveFedora::IndexingService
  include Hyrax::IndexesThumbnails
  self.thumbnail_path_service = Hyrax::WorkThumbnailPathService

  # This indexes the default metadata. You can remove it if you want to
  # provide your own metadata and indexing.
  included Hyrax::IndexesBasicMetadata do
    self.stored_and_facetable_fields = []
    self.stored_fields = []
    self.symbol_fields = []
  end

  # Custom indexing behavior
  def generate_solr_document
    super.tap do |solr_doc|
      # basic fields
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
    end
  end

end
