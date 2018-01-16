# Generated via
#  `rails generate hyrax:work RdssCdm`
class RdssCdm < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  # include methods to check for enabled and disabled content types
  include EnableContentTypesBehaviour  


  self.indexer = RdssCdmIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }
  validates :object_resource_type, presence: { message: 'Your work must have a resource type.' }
  validates :object_value, presence: { message: 'Your work must have a value.' }

  self.human_readable_type = 'RDSS CDM'

  property :object_uuid, predicate: ::RDF::Vocab::DC11.identifier, multiple: false 
  # object_title present as `title` inherited from Hyrax::CoreMetadata
  #property :object_person_role
  property :object_description, predicate: ::RDF::Vocab::DC11.description, multiple: false do |index|
    index.as :stored_searchable
  end
  #property :object_rights
  #property :object_date
  property :object_keywords, predicate: ::RDF::Vocab::DC11.relation do |index|
    index.as :stored_searchable, :facetable
  end
  property :object_category, predicate: ::RDF::Vocab::PROV.category do |index|
    index.as :stored_searchable, :facetable
  end 
  
  property :object_resource_type, predicate: ::RDF::Vocab::DC.type, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :object_version, predicate: ::RDF::Vocab::DOAP.Version, multiple: false do |index|
    index.as :stored_searchable
  end

  property :object_value, predicate: ::RDF::Vocab::ICAL.priority, multiple: false do |index|
    index.as :stored_searchable
  end
  #property :object_identifier
  #property :object_related_identifier
  #property :object_organisation_role
  #property :object_preservation_event
  #property :object_file

  # object_date nested relationship
  has_many :object_dates, class_name: 'Cdm::Date'

  # Accepts nested attributes declarations need to go after the property declarations, as they close off the model
  accepts_nested_attributes_for :object_dates

  
  def self.multiple?(field)
    # Overriding to return false for `title` (as we can't set multiple: false) 
    if [:title].include? field.to_sym
      false
    else
      super
    end
  end

  def self.model_attributes(_)
    # Overriding to cast title back to multivalue when saving. 
    attrs = super
    attrs[:title] = Array(attrs[:title]) if attrs[:title]
    attrs
  end

  def title
    # Return a single value for form field population. 
    super.first || ""
  end
  
  # The following properties are also inherited from Hyrax::CoreMetadata 
  # along with :title and are required by Hyrax:
  # :depositor
  # :date_uploaded
  # :date_modified

  id_blank = proc { |attributes| attributes[:id].blank? }

  #class_attribute :controlled_properties
  #self.controlled_properties = [:based_near]
  #accepts_nested_attributes_for :based_near, reject_if: id_blank, allow_destroy: true

end
