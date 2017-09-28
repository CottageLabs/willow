# accepts_nested_attributes_for can not be called until all the properties are declared
# because it calls resource_class, which finalizes the propery declarations
# See https://github.com/projecthydra/active_fedora/issues/847
module DatasetNestedAttributes
  extend ActiveSupport::Concern

  included do
    id_blank = proc { |attributes| attributes[:id].blank? }

    accepts_nested_attributes_for :other_title, reject_if: :other_title_blank, allow_destroy: true
    accepts_nested_attributes_for :date, reject_if: :date_blank, allow_destroy: true
    accepts_nested_attributes_for :creator_nested, reject_if: :creator_blank, allow_destroy: true
    accepts_nested_attributes_for :license_nested, reject_if: :license_blank, allow_destroy: true
    accepts_nested_attributes_for :subject_nested, reject_if: :subject_blank, allow_destroy: true
    accepts_nested_attributes_for :relation, reject_if: :relation_blank, allow_destroy: true
    accepts_nested_attributes_for :admin_metadata, reject_if: :admin_metadata_blank, allow_destroy: true
    accepts_nested_attributes_for :identifier_nested, reject_if: :identifier_blank, allow_destroy: true

    # other_title_blank
    resource_class.send(:define_method, :other_title_blank) do |attributes|
      Array(attributes[:title]).all?(&:blank?)
    end

    # date_blank
    resource_class.send(:define_method, :date_blank) do |attributes|
      Array(attributes[:date]).all?(&:blank?)
    end

    # creator_blank
    resource_class.send(:define_method, :creator_blank) do |attributes|
      (Array(attributes[:first_name]).all?(&:blank?) &&
      Array(attributes[:last_name]).all?(&:blank?)) ||
      Array(attributes[:role]).all?(&:blank?) ||
      Array(attributes[:orcid]).all?(&:blank?)
    end

    # license_blank - similar to all_blank for defined license attributes
    resource_class.send(:define_method, :license_blank) do |attributes|
      license_attributes.all? do |key|
        Array(attributes[key]).all?(&:blank?)
      end
    end

    resource_class.send(:define_method, :license_attributes) do
      [:label, :definition, :webpage]
    end

    # subject_blank
    resource_class.send(:define_method, :subject_blank) do |attributes|
      Array(attributes[:label]).all?(&:blank?)
    end

    # relation_blank
    # Need label, url / identifier, relationship name / relationship role
    resource_class.send(:define_method, :relation_blank) do |attributes|
      (Array(attributes[:label]).all?(&:blank?) ||
      (Array(attributes[:url]).all?(&:blank?) &&
      Array(attributes[:identifier]).all?(&:blank?))) ||
      (Array(attributes[:relationship_role]).all?(&:blank?) &&
      Array(attributes[:relationship_name]).all?(&:blank?))
    end

    # admin_metadata_blank
    resource_class.send(:define_method, :admin_metadata_blank) do |attributes|
      Array(attributes[:question]).all?(&:blank?)
    end

    # identifier_blank - need identifier and scheme attributes
    resource_class.send(:define_method, :identifier_blank) do |attributes|
      (Array(attributes[:obj_id]).all?(&:blank?) ||
       Array(attributes[:obj_id_scheme]).all?(&:blank?))
    end
  end
end
