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
  # You can't validate associations with ActiveFedora/Solr since it tries to do an http connection to Solr to reconcile
  # how many documents there are. There's a note
  # validates :object_person_roles, presence: { message: I18n.t('willow.fields.presence', type: I18n.t('willow.fields.object_person_role').downcase)}
  # validates :object_organisation_roles, presence: true
  # validates :object_people, presence: { message: I18n.t('willow.fields.presence', type: I18n.t('willow.fields.object_person').downcase)}

  self.human_readable_type = 'RDSS CDM'

  property :object_uuid, predicate: ::RDF::Vocab::DC11.identifier, multiple: false
  # object_title present as `title` inherited from Hyrax::CoreMetadata
  has_many :object_person_roles, class_name: 'Cdm::ObjectPersonRole'
  has_many :object_people, class_name: 'Cdm::ObjectPerson'
  property :object_description, predicate: ::RDF::Vocab::DC11.description, multiple: false do |index|
    index.as :stored_searchable
  end
  #property :object_rights

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
  has_many :object_identifiers, class_name: 'Cdm::Identifier'

  #property :object_related_identifier
  #property :object_organisation_role
  #property :object_preservation_event
  #property :object_file

  # object_date nested relationship
  has_many :object_dates, class_name: 'Cdm::Date'

  # object_rights nested relationship.
  # This is a has_many in the CDM but for presentation and form purposes it is presented as a has_one
  has_many :object_rights, class_name: 'Cdm::Rights'

  has_many :object_organisation_roles, class_name: 'Cdm::ObjectOrganisationRole'

  # Accepts nested attributes declarations need to go after the property declarations, as they close off the model
  accepts_nested_attributes_for :object_dates, reject_if: :object_dates_blank?, allow_destroy: true
  accepts_nested_attributes_for :object_organisation_roles, allow_destroy: true, reject_if: :object_organisation_roles_blank?
  accepts_nested_attributes_for :object_people, allow_destroy: true, reject_if: :object_person_blank?
  accepts_nested_attributes_for :object_rights

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

  # methods for validation of nested properties
  # For properties with a class_name These need to go on the resource_class: RdssCdm::GeneratedResourceSchema
  # For associated models, these should be instance methods

  # object_date_blank
  # Reject a nested object_date if the value for date_value is not set
  #
  #
  def all_blank?(attributes, *list)
    attributes.values_at(*list).all?(&:blank?)
  end

  def any_blank?(attributes, *list)
    attributes.values_at(*list).any?(&:blank?)
  end

  def object_dates_blank?(attributes)
    any_blank?(attributes, :date_value, :date_type)
  end

  def object_person_roles_blank?(attributes)
    any_blank?(attributes, :role_type)
  end

  def object_person_blank?(attributes)
    all_blank?(attributes, :given_name, :family_name)
  end

  def object_organisation_roles_blank?(attributes)
    any_blank?(attributes, :role)
  end
end
