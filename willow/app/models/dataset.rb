# Generated via
#  `rails generate curation_concerns:work Dataset`

class Dataset < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include ::CurationConcerns::BasicMetadata
  include Sufia::WorkBehavior
  self.human_readable_type = 'Dataset'
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  property :doi, predicate: ::RDF::Vocab::Identifiers.doi, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end
  property :publisher, predicate: ::RDF::Vocab::DC.publisher do |index|
    index.as :stored_searchable, :facetable
  end
  property :other_title, predicate: ::RDF::Vocab::Bibframe.titleVariation, class_name:"OtherTitleStatement"
  property :date, predicate: ::RDF::Vocab::DC.date, class_name:"DateStatement"
  property :creator_nested, predicate: ::RDF::Vocab::DC.license, class_name:"PersonStatement"
  property :rights_nested, predicate: ::RDF::Vocab::DC.rights, class_name:"RightsStatement"
  property :subject_nested, predicate: ::RDF::Vocab::DC.subject, class_name:"SubjectStatement"
  property :relation, predicate: ::RDF::Vocab::DC.relation, class_name:"RelationStatement"
  property :admin_metadata, predicate: ::RDF::Vocab::MODS.adminMetadata, class_name: "AdministrativeStatement"

  validates :title, presence: { message: 'Your work must have a title.' }
  validates :doi, presence: { message: 'Your work must have a doi.' }

  # must be included after all properties are declared
  include NestedAttributes

  def to_solr(solr_doc = {})
    super(solr_doc).tap do |doc|
      # other title
      doc[Solrizer.solr_name('other_title', :stored_searchable)] = other_title.map { |r| r.title.first }
      doc[Solrizer.solr_name('other_title', :displayable)] = other_title.to_json
      # date
      doc[Solrizer.solr_name('date', :stored_searchable)] = date.map { |d| d.date.first }
      doc[Solrizer.solr_name('date', :displayable)] = date.to_json
      date.each do |d|
        label = DateTypesService.label(d.description.first) rescue nil
        if label
          doc[Solrizer.solr_name("date_#{label.downcase}", :stored_sortable)] = d.date
        end
      end
      # creator
      creators = creator_nested.map { |c| (c.first_name + c.last_name).join(' ') }
      doc[Solrizer.solr_name('creator_nested', :facetable)] = creators
      doc[Solrizer.solr_name('creator_nested', :stored_searchable)] = creators
      doc[Solrizer.solr_name('creator_nested', :displayable)] = creator_nested.to_json
      # rights
      doc[Solrizer.solr_name('rights_nested', :stored_searchable)] = rights_nested.map { |r| r.webpage.first }
      doc[Solrizer.solr_name('rights_nested', :facetable)] = rights_nested.map { |r| r.webpage.first }
      doc[Solrizer.solr_name('rights_nested', :displayable)] = rights_nested.to_json
      # subject
      doc[Solrizer.solr_name('subject_nested', :stored_searchable)] = subject_nested.map { |s| s.label.first }
      doc[Solrizer.solr_name('subject_nested', :facetable)] = subject_nested.map { |s| s.label.first }
      doc[Solrizer.solr_name('subject_nested', :displayable)] = subject_nested.to_json
      # relation
      doc[Solrizer.solr_name('relation_url', :facetable)] = relation.map { |r| r.url.first }
      doc[Solrizer.solr_name('relation_id', :facetable)] = relation.map { |r| r.identifier.first }
      doc[Solrizer.solr_name('relation', :displayable)] = relation.to_json
      # admin metadata
      doc[Solrizer.solr_name('admin_metadata', :displayable)] = admin_metadata.to_json
    end
  end

end
