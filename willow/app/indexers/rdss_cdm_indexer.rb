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
        
        if d.date_value
          date = begin
            ::Date.parse(d.date_value.to_s)
          rescue ArgumentException
            nil
          end
          if date
            solr_doc[Solrizer.solr_name("object_dates_#{d.date_type}", :stored_sortable, type: :date)] = date.strftime('%FT%TZ')
          end
        end
      end

      object_people = object.object_people.reject(&:marked_for_destruction?)
      solr_doc[Solrizer.solr_name("object_people", :displayable)] = object_people.to_json(include: :object_person_roles)

      # object rights
      # At the moment we have a has_one relationship between Object and Object rights. As such it makes more sense to
      # index the object_rights fields as direct fields on the solr document
      rights = object.object_rights.first
      if rights
        solr_doc[Solrizer.solr_name('object_rights_licence', :stored_searchable)] = rights.licence
        solr_doc[Solrizer.solr_name('object_rights_rights_statement', :stored_searchable)] = rights.rights_statement
        solr_doc[Solrizer.solr_name('object_rights_rights_holder', :stored_searchable)] = rights.rights_holder
        # nested accesses
        # we need to manually remove any that are marked for destruction
        accesses = rights.accesses.reject(&:marked_for_destruction?)
        # make access types searchable
        solr_doc[Solrizer.solr_name('object_rights_access_type', :stored_searchable)] = accesses.map(&:access_type)
        # for display include the entire nested access as json
        solr_doc[Solrizer.solr_name('object_rights_accesses', :displayable)] = accesses.to_json
      end

      object_organisation_roles = object.object_organisation_roles.reject(&:marked_for_destruction?)
      solr_doc[::Solrizer.solr_name(:object_organisation_roles, :displayable)] = object_organisation_roles.to_json
      object_organisation_roles.each do |object_organisation_role|
        solr_doc[::Solrizer.solr_name("object_organisation_role_#{object_organisation_role.role}", :stored_sortable)] = true
      end

      # Index a displayable version of the identifier
      object_identifiers = object.object_identifiers.reject(&:marked_for_destruction?)
      solr_doc[Solrizer.solr_name('object_identifiers', :displayable)] = object_identifiers.to_json
      # Incase we need it, solarize each identifier type
      object_identifiers.each do |i|
        solr_doc[Solrizer.solr_name("object_identifier_#{i.identifier_type}", :stored_sortable)] = i.identifier_value
      end

      # Index a displayable version of the related identifier
      object_related_identifiers = object.object_related_identifiers.reject(&:marked_for_destruction?)
      solr_doc[Solrizer.solr_name('object_related_identifiers', :displayable)] = object_related_identifiers.to_json(include: :identifier)
    end
  end
end
