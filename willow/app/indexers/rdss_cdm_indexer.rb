# Generated via
#  `rails generate hyrax:work RdssCdm`
class RdssCdmIndexer < Hyrax::WorkIndexer
  # This indexes the default metadata. You can remove it if you want to
  # provide your own metadata and indexing.
  #include Hyrax::IndexesBasicMetadata

  def generate_solr_document
    super.tap do |solr_doc|
      solr_doc[Solrizer.solr_name('title', :stored_searchable)] = object.title
      solr_doc[Solrizer.solr_name('object_description', :stored_searchable)] = object.object_description
    end
  end
end
