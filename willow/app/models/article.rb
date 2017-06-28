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
  property :doi, predicate: ::RDF::Vocab::Identifiers.doi, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end
  property :publisher, predicate: ::RDF::Vocab::DC.publisher do |index|
    index.as :stored_searchable, :facetable
  end
  property :coverage, predicate: ::RDF::Vocab::DC.coverage do |index|
    index.as :stored_searchable
  end
  property :apc, predicate: RioxxTerms.apc do |index|
    index.as :stored_searchable
  end
  property :version, predicate: RioxxTerms.version do |index|
    index.as :stored_searchable, :facetable
  end
  property :date, predicate: ::RDF::Vocab::DC.date, class_name:"DateStatement"
  property :creator_nested, predicate: ::RDF::Vocab::DC.license, class_name:"PersonStatement"
  property :rights_nested, predicate: ::RDF::Vocab::DC.license, class_name:"RightsStatement"
  property :subject_nested, predicate: ::RDF::Vocab::DC.subject, class_name:"SubjectStatement"
  property :relation, predicate: ::RDF::Vocab::DC.relation, class_name:"RelationStatement"
  property :admin_metadata, predicate: ::RDF::Vocab::MODS.adminMetadata, class_name: "AdministrativeStatement"
  property :project, predicate: RioxxTerms.project, class_name:"ProjectStatement"

  validates :title, presence: { message: 'Your work must have a title.' }

  include ArticleNestedAttributes

  def to_solr(solr_doc = {})
    super(solr_doc).tap do |doc|
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
      creators = creator_nested.map { |c| (c.first_name + c.last_name).reject(&:blank?).join(' ') }
      doc[Solrizer.solr_name('creator_nested', :facetable)] = creators
      doc[Solrizer.solr_name('creator_nested', :stored_searchable)] = creators
      doc[Solrizer.solr_name('creator_nested', :displayable)] = creator_nested.to_json
      # rights
      doc[Solrizer.solr_name('rights_nested', :stored_searchable)] = rights_nested.map { |r| r.webpage.first }.reject(&:blank?)
      doc[Solrizer.solr_name('rights_nested', :facetable)] = rights_nested.map { |r| r.webpage.first }.reject(&:blank?)
      doc[Solrizer.solr_name('rights_nested', :displayable)] = rights_nested.to_json
      # subject
      doc[Solrizer.solr_name('subject_nested', :stored_searchable)] = subject_nested.map { |s| s.label.first }.reject(&:blank?)
      doc[Solrizer.solr_name('subject_nested', :facetable)] = subject_nested.map { |s| s.label.first }.reject(&:blank?)
      doc[Solrizer.solr_name('subject_nested', :displayable)] = subject_nested.to_json
      # relation
      doc[Solrizer.solr_name('relation_url', :facetable)] = relation.map { |r| r.url.first }.reject(&:blank?)
      doc[Solrizer.solr_name('relation_id', :facetable)] = relation.map { |r| r.identifier.first }.reject(&:blank?)
      doc[Solrizer.solr_name('relation', :displayable)] = relation.to_json
      # admin metadata
      doc[Solrizer.solr_name('admin_metadata', :displayable)] = admin_metadata.to_json
      # project
      doc[Solrizer.solr_name('project_id', :stored_sortable)] = project.map { |p| p.identifier.first }.reject(&:blank?)
      doc[Solrizer.solr_name('project', :stored_searchable)] = project.map { |p| p.title.first }.reject(&:blank?)
      doc[Solrizer.solr_name('funder', :stored_searchable)] = project.map { |p| p.funder_name.first }.reject(&:blank?)
      doc[Solrizer.solr_name('funder', :facetable)] = project.map { |p| p.funder_name.first }.reject(&:blank?)
      doc[Solrizer.solr_name('funder_id', :facetable)] = project.map { |p| p.funder_id.first }.reject(&:blank?)
      doc[Solrizer.solr_name('grant_number', :stored_sortable)] = project.map { |p| p.grant_number.first }.reject(&:blank?)
      doc[Solrizer.solr_name('project', :displayable)] = project.to_json
    end
  end

end
