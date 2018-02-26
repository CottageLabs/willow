module Cdm
  class ObjectPerson < ActiveFedora::Base
    property :honorific_prefix, predicate: ::RDF::Vocab::FOAF.title, multiple: false
    property :given_name, predicate: ::RDF::Vocab::FOAF.givenName, multiple: false
    property :family_name, predicate: ::RDF::Vocab::FOAF.familyName, multiple: false
    has_and_belongs_to_many :object_person_roles,
                            class_name: 'Cdm::ObjectPersonRole',
                            predicate: ::RDF::Vocab::VMD.affiliation,
                            inverse_of: :object_person,
                            autosave: true
    belongs_to :rdss_cdm, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf
    validates :object_person_roles, presence: { message: I18n.t('willow.fields.presence', type: I18n.t('willow.fields.object_person_role').downcase)}
    validate :has_given_name_or_family_name

    accepts_nested_attributes_for :object_person_roles, allow_destroy: true, reject_if: :object_person_roles_blank?

    def has_given_name_or_family_name
      attributes.values_at('given_name', 'family_name').all?(&:blank?) && errors.add(:given_name, I18n.t('willow.fields.given_and_family_name_presence'))
    end

    def any_blank?(attributes, *list)
      attributes.values_at(*list).any?(&:blank?)
    end

    def display_name
      [
        honorific_prefix,
        given_name,
        family_name
      ].join(' ').squish
    end

    def object_person_roles_blank?(attributes)
      any_blank?(attributes, :role_type)
    end
  end
end
