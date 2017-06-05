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
  property :publication_date, predicate: ::RDF::Vocab::DC.date do |index|
    index.as :stored_searchable
  end
  property :creator, predicate: ::RDF::Vocab::DC.license, class_name:"PersonStatement"
  property :other_title, predicate: ::RDF::Vocab::Bibframe.titleVariation, class_name:"OtherTitleStatement"
  property :rights, predicate: ::RDF::Vocab::DC.rights, class_name:"RightsStatement"

  property :relation, predicate: ::RDF::Vocab::DC.relation, class_name:"RelationStatement"
  property :publication, predicate: ::RDF::Vocab::DC.isReferencedBy, class_name: "PublicationStatement"
  property :admin_metadata, predicate: ::RDF::Vocab::MODS.adminMetadata, class_name: "AdministrativeStatement"

  validates :title, presence: { message: 'Your work must have a title.' }
  validates :doi, presence: { message: 'Your work must have a doi.' }

  # must be included after all properties are declared
  include NestedAttributes

  RESOURCE_TYPE_QUALIFIERS = [
    'Audiovisual',
    'Collection',
    'Dataset',
    'Event',
    'Image',
    'InteractiveResource',
    'Model',
    'PhysicalObject',
    'Service',
    'Software',
    'Sound',
    'Text',
    'Workflow',
    'Other',
  ]

  def self.resource_type_qualifiers
    RESOURCE_TYPE_QUALIFIERS
  end

  def to_solr(solr_doc = {})
    super(solr_doc).tap do |doc|
      # other title
      doc[Solrizer.solr_name('other_title', :stored_searchable)] = other_title.map { |r| r.title.first }
      # rights
      doc[Solrizer.solr_name('rights', :stored_searchable)] = rights.to_json
      doc[Solrizer.solr_name('rights', :facetable)] = rights.map { |l| l.label.first }
      # creator
      doc[Solrizer.solr_name('person', :stored_searchable)] = creator.to_json
      creators = creator.map { |c| (c.first_name + c.last_name).join(' ') }
      doc[Solrizer.solr_name('creator', :facetable)] = creators
      doc[Solrizer.solr_name('creator', :stored_searchable)] = creators
      # relation
      doc[Solrizer.solr_name('relation', :stored_searchable)] = relation.map { |r| r.url.first }
      # publication
      doc[Solrizer.solr_name('publication', :stored_searchable)] = publication.map { |p| p.title.first }
      doc[Solrizer.solr_name('journal', :stored_searchable)] = publication.map { |p| p.journal.first }
      doc[Solrizer.solr_name('journal', :facetable)] = publication.map { |p| p.journal.first }
    end
  end

end
