# Generated via
#  `rails generate hyrax:work RdssCdm`
class RdssCdmIndexer < Hyrax::WorkIndexer
  def generate_solr_document
    super.tap do |solr_doc|
      # Enter any manual indexing code here
      # if possible, indexing should be specified within the model

      # Index a displayable version of the object date
      # Indexing appears to be occuring before the record is saved to the database
      # so we need to filter the list and reject any that are marked_for_destruction?
      # Otherwise we will be showing dates that have been deleted
      object_dates = object.object_dates.reject(&:marked_for_destruction?)
      solr_doc[Solrizer.solr_name('object_dates', :displayable)] = object_dates.to_json
      
      # for each object date, index a value for the specific date type to allow sorting by the date type
      # eg object_date_approved
      # As above, we are using the object_dates filtered to remove marked_for_destruction?
      object_dates.each do |d|
        label = RdssDateTypesService.label(d.date_type) rescue nil
        if label
          solr_doc[Solrizer.solr_name("object_dates_#{label.downcase}", :stored_sortable)] = d.date_value
        end
      end

      object_people = object.object_people.reject(&:marked_for_destruction?)
      solr_doc[Solrizer.solr_name("object_people", :displayable)] = object_people.to_json(include: :object_person_roles)
    end
  end
end
