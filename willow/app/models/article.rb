# Generated via
#  `rails generate hyrax:work Article`
require "./lib/vocabularies/rioxxterms"
class Article < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  self.indexer = ArticleIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  self.human_readable_type = 'Article'

  property :apc, predicate: RioxxTerms.apc do |index|
    index.as :stored_searchable
  end
  property :coverage, predicate: ::RDF::Vocab::DC.coverage do |index|
    index.as :stored_searchable
  end
  property :doi, predicate: ::RDF::Vocab::Identifiers.doi, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end
  property :publisher, predicate: ::RDF::Vocab::DC.publisher do |index|
    index.as :stored_searchable, :facetable
  end
  property :tagged_version, predicate: RioxxTerms.version do |index|
    index.as :stored_searchable, :facetable
  end
  property :admin_metadata, predicate: ::RDF::Vocab::MODS.adminMetadata, class_name: "AdministrativeStatement"
  property :creator_nested, predicate: ::RDF::Vocab::SIOC.has_creator, class_name:"PersonStatement"
  property :date, predicate: ::RDF::Vocab::DC.date, class_name:"DateStatement"
  property :project, predicate: RioxxTerms.project, class_name:"ProjectStatement"
  property :relation, predicate: ::RDF::Vocab::DC.relation, class_name:"RelationStatement"
  property :license_nested, predicate: ::RDF::Vocab::DC.license, class_name:"LicenseStatement"
  property :subject_nested, predicate: ::RDF::Vocab::DC.subject, class_name:"SubjectStatement"
  property :identifier_nested, predicate: ::RDF::Vocab::Identifiers.id, class_name: "ObjectIdentifier"

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
  include ArticleNestedAttributes
end
