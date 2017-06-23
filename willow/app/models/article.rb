require "./lib/vocabularies/rioxxterms"
# Generated via
#  `rails generate curation_concerns:work Article`
class Article < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include ::CurationConcerns::BasicMetadata
  include Sufia::WorkBehavior
  self.human_readable_type = 'Article'
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  property :coverage, predicate: ::RDF::Vocab::DC.coverage do |index|
    index.as :stored_searchable
  end
  property :apc, predicate: RioxxTerms.apc, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end
  property :project, predicate: RioxxTerms.project, class_name:"ProjectStatement"
  property :version, predicate: RioxxTerms.version, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  validates :title, presence: { message: 'Your work must have a title.' }

  # include ArticleNestedAttributes

  def to_solr(solr_doc = {})
    super(solr_doc).tap do |doc|
      # coverage
      doc[Solrizer.solr_name('coverage', :stored_searchable)] = coverage
      # apc
      doc[Solrizer.solr_name('apc', :stored_searchable)] = apc
      doc[Solrizer.solr_name('apc', :facetable)] = apc
      # project
      doc[Solrizer.solr_name('project', :facetable)] = project.map { |p| p.identifier.first }
      doc[Solrizer.solr_name('funder', :stored_searchable)] = project.map { |p| p.funder_name.first }
      doc[Solrizer.solr_name('funder', :facetable)] = project.map { |p| p.funder_name.first }
      # version
      doc[Solrizer.solr_name('version', :stored_searchable)] = apc
      doc[Solrizer.solr_name('version', :facetable)] = apc
    end
  end

end
