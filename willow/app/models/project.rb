class Project < ActiveFedora::Base
  include ::BasicModelBehavior

  self.indexer = ProjectIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []

  self.human_readable_type = 'Project'

  # TODO: Relate project to collection
  #       Have not related project to hyrax collection as it is not a Hyrax Work

  property :title, predicate: ::RDF::Vocab::DC.title do |index|
    index.as :stored_searchable
  end
  property :description, predicate: ::RDF::Vocab::DC.description do |index|
    index.as :stored_searchable
  end
  property :start_date, predicate: ::RDF::Vocab::MADS.activityStartDate do |index|
    index.as :dateable, :stored_sortable
  end
  property :end_date, predicate: ::RDF::Vocab::MADS.activityEndDate do |index|
    index.as :dateable, :stored_sortable
  end
  property :identifier_nested, predicate: ::RDF::Vocab::Identifiers.id, class_name: "ObjectIdentifier"
  include ProjectNestedAttributes
  # has many grants
  has_and_belongs_to_many :grants, predicate: ::RDF::URI.new('http://purl.org/cerif/frapo/isFundedBy')
end
