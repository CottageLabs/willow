# Generated via
#  `rails generate hyrax:work RdssCdm`
class RdssCdmIndexer < Hyrax::WorkIndexer
  def generate_solr_document
    super.tap do |solr_doc|
      # Enter any manual indexing code here
      # if possible, indexing should be specified within the model

      # index a displayable version of the object date
      solr_doc[Solrizer.solr_name('object_dates', :displayable)] = object.object_dates.to_json
      
      # for each object date, index a value for the specific date type to allow sorting by the date type
      # eg object_date_approved
      object.object_dates.each do |d|
        label = RdssDateTypesService.label(d.date_type) rescue nil
        if label
          solr_doc[Solrizer.solr_name("object_dates_#{label.downcase}", :stored_sortable)] = d.date_value
        end
      end
    end
  end
end
