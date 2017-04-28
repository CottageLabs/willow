# Generated via
#  `rails generate curation_concerns:work Dataset`

class Dataset < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include ::CurationConcerns::BasicMetadata
  include Sufia::WorkBehavior
  self.human_readable_type = 'Dataset'
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  property :license, predicate: ::RDF::Vocab::DC.license, class_name:"LicenseStatement"
  property :creator, predicate: ::RDF::Vocab::DC.license, class_name:"Person"

  # must be included after all properties are declared
  include NestedAttributes

  def to_solr(solr_doc = {})
    super(solr_doc).tap do |doc|
      doc[Solrizer.solr_name('license', :stored_searchable)] = license.to_json
      doc[Solrizer.solr_name('license', :facetable)] = license.map { |l| l.label.first }
      doc[Solrizer.solr_name('creator', :stored_searchable)] = creator.to_json
      doc[Solrizer.solr_name('creator', :facetable)] = creator.map {
        |c| (c.first_name.first + ' ' + c.last_name.first).strip }
    end
  end

end
