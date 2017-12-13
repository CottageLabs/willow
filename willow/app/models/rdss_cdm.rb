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

  self.human_readable_type = 'RDSS CDM'

  property :object_uuid, predicate: ::RDF::Vocab::DC11.identifier, multiple: false 
  # object_title present as `title` inherited from Hyrax::CoreMetadata
  #property :object_person_role
  property :object_description, predicate: ::RDF::Vocab::DC11.description, multiple: false
  #property :object_rights
  #property :object_date
  property :object_keywords, predicate: ::RDF::Vocab::DC11.relation
  property :object_category, predicate: ::RDF::Vocab::DC11.relation
  #property :object_resource_type
  property :object_version, predicate: ::RDF::Vocab::DOAP.Version
  #property :object_value
  #property :object_identifier
  #property :object_related_identifier
  #property :object_organisation_role
  #property :object_preservation_event
  #property :object_file
  
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
