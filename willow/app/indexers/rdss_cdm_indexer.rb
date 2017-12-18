# Generated via
#  `rails generate hyrax:work RdssCdm`
class RdssCdmIndexer < Hyrax::WorkIndexer
  # This indexes the default metadata. You can remove it if you want to
  # provide your own metadata and indexing.
  include Hyrax::IndexesBasicMetadata
  
  # Overwriting these properties from Hyrax::IndexesBasicMetadata
  self.stored_and_facetable_fields = %i[object_keywords object_category]
  self.stored_fields = %i[title object_description object_version]
  self.symbol_fields = %i[object_uuid]

  #def generate_solr_document
  #  super.tap do |solr_doc|
  #    solr_doc[Solrizer.solr_name('title', :stored_searchable)] = object.title
  #  end
  #end
end
