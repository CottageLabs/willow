# Generated via
#  `rails generate hyrax:work Dataset`
class DatasetIndexer < Hyrax::WorkIndexer
  # This indexes the default metadata. You can remove it if you want to
  # provide your own metadata and indexing.
  include Hyrax::IndexesBasicMetadata

  # Fetch remote labels for based_near. You can remove this if you don't want
  # this behavior
  include Hyrax::IndexesLinkedMetadata

  def generate_solr_document
    super.tap do |solr_doc|
      # date
      solr_doc[Solrizer.solr_name('date', :stored_searchable)] = object.date.map { |d| d.date.first }
      solr_doc[Solrizer.solr_name('date', :displayable)] = object.date.to_json
      object.date.each do |d|
        label = DateTypesService.label(d.description.first) rescue nil
        if label
          solr_doc[Solrizer.solr_name("date_#{label.downcase}", :stored_sortable)] = d.date
        end
      end
      # person and role
      creators = object.creator_nested.map { |c| (c.name.first) }.reject(&:blank?).uniq
      solr_doc[Solrizer.solr_name('creator_nested', :facetable)] = creators
      solr_doc[Solrizer.solr_name('creator_nested', :stored_searchable)] = creators
      solr_doc[Solrizer.solr_name('creator_nested', :displayable)] = object.creator_nested.to_json
      object.creator_nested.each do |c|
        unless (c.role.first.blank? or c.name.blank?)
          field_name = Solrizer.solr_name("#{c.role.first.downcase}", :stored_searchable)
          solr_doc[field_name] ||= []
          solr_doc[field_name].push(*c.name.reject(&:blank?))
          field_name = Solrizer.solr_name("#{c.role.first.downcase}", :facetable)
          solr_doc[field_name] ||= []
          solr_doc[field_name].push(*c.name.reject(&:blank?))
        end
      end
      solr_doc[Solrizer.solr_name('orcid', :symbol)] = object.creator_nested.map { |c| c.orcid.first }.reject(&:blank?)
      # rights
      solr_doc[Solrizer.solr_name('license_nested', :stored_searchable)] = object.license_nested.map { |r| r.webpage.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('license_nested', :facetable)] = object.license_nested.map { |r| r.webpage.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('license_nested', :displayable)] = object.license_nested.to_json
      # relation
      solr_doc[Solrizer.solr_name('relation_url', :facetable)] = object.relation.map { |r| r.url.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('relation_id', :facetable)] = object.relation.map { |r| r.identifier.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('relation', :displayable)] = object.relation.to_json
      # identifier
      solr_doc[Solrizer.solr_name('identifier_nested', :symbol)] = object.identifier_nested.map { |i| i.obj_id.first }
      solr_doc[Solrizer.solr_name('identifier_nested', :displayable)] = object.identifier_nested.to_json
      object.identifier_nested.each do |i|
        unless (i.obj_id_scheme.first.blank? or i.obj_id.first.blank?)
          solr_doc[Solrizer.solr_name("identifier_#{i.obj_id_scheme.first.downcase}", :symbol)] = i.obj_id.reject(&:blank?)
        end
      end
      # organisation and role
      orgs = object.organisation_nested.map { |o| (o.name.first) }.reject(&:blank?).uniq
      solr_doc[Solrizer.solr_name('organisation_nested', :facetable)] = orgs
      solr_doc[Solrizer.solr_name('organisation_nested', :stored_searchable)] = orgs
      solr_doc[Solrizer.solr_name('organisation_nested', :displayable)] = object.organisation_nested.to_json
      object.organisation_nested.each do |o|
        unless (o.role.first.blank? or o.name.blank?)
          field_name = Solrizer.solr_name("#{o.role.first.downcase}", :stored_searchable)
          solr_doc[field_name] ||= []
          solr_doc[field_name].push(*o.name.reject(&:blank?))
          field_name = Solrizer.solr_name("#{o.role.first.downcase}", :facetable)
          solr_doc[field_name] ||= []
          solr_doc[field_name].push(*o.name.reject(&:blank?))
        end
      end
      # preservation
      events = object.preservation_nested.map { |p| (p.name.first) }.reject(&:blank?).uniq
      solr_doc[Solrizer.solr_name('preservation_nested', :facetable)] = events
      solr_doc[Solrizer.solr_name('preservation_nested', :stored_searchable)] = events
      solr_doc[Solrizer.solr_name('preservation_nested', :displayable)] = object.preservation_nested.to_json
    end
  end
end
