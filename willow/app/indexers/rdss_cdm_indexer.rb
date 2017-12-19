# Generated via
#  `rails generate hyrax:work RdssCdm`
class RdssCdmIndexer < Hyrax::WorkIndexer
  def generate_solr_document
    super.tap do |solr_doc|

      solr_doc[Solrizer.solr_name('title', :stored_searchable)] = object.title

      solr_doc[Solrizer.solr_name('object_description', :stored_searchable)] = object.object_description 

      solr_doc[Solrizer.solr_name('object_keywords', :stored_searchable)] = object.object_keywords
      solr_doc[Solrizer.solr_name('object_keywords', :facetable)] = object.object_keywords

      solr_doc[Solrizer.solr_name('object_category', :stored_searchable)] = object.object_category 
      solr_doc[Solrizer.solr_name('object_category', :facetable)] = object.object_category 
    end
  end
end
