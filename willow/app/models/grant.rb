# Generated via
#  `rails generate hyrax:work Book`
class Grant < ActiveFedora::Base
  include ::BasicModelBehavior

  self.indexer = GrantIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []

  self.human_readable_type = 'Grant'

  property :title, predicate: ::RDF::Vocab::DC.title do |index|
    index.as :stored_searchable
  end
  property :start_date, predicate: ::RDF::URI.new('http://purl.org/cerif/frapo/hasStartDate') do |index|
    index.as :dateable, :stored_sortable
  end
  property :end_date, predicate: ::RDF::URI.new('http://purl.org/cerif/frapo/hasEndDate') do |index|
    index.as :dateable, :stored_sortable
  end
  property :value, predicate: ::RDF::URI.new('http://purl.org/cerif/frapo/Funding') do |index|
    index.as :sortable, :displayable
  end
  # grant number
  property :identifier_nested, predicate: ::RDF::URI.new('http://purl.org/cerif/frapo/hasGrantNumber'), class_name: "ObjectIdentifier"
  include ProjectNestedAttributes
  has_many :projects
end
