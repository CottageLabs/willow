# accepts_nested_attributes_for can not be called until all the properties are declared
# because it calls resource_class, which finalizes the propery declarations
# See https://github.com/projecthydra/active_fedora/issues/847
module NestedAttributes
  extend ActiveSupport::Concern

  included do
    id_blank = proc { |attributes| attributes[:id].blank? }

    accepts_nested_attributes_for :license, reject_if: :license_blank, allow_destroy: true
    accepts_nested_attributes_for :creator, reject_if: :creator_blank, allow_destroy: true
    accepts_nested_attributes_for :relation, reject_if: :relation_blank, allow_destroy: true

    # license_blank - similar to all_blank for defined license attributes
    resource_class.send(:define_method, :license_blank) do |attributes|
      license_attributes.all? do |key|
        Array(attributes[key]).all?(&:blank?)
      end
    end

    resource_class.send(:define_method, :license_attributes) do
      [:label, :definition, :webpage]
    end

    # creator_blank
    resource_class.send(:define_method, :creator_blank) do |attributes|
      (Array(attributes[:first_name]).all?(&:blank?) &&
      Array(attributes[:last_name]).all?(&:blank?)) ||
      Array(attributes[:role]).all?(&:blank?) ||
      Array(attributes[:orcid]).all?(&:blank?)
    end

    # relation_blank
    resource_class.send(:define_method, :relation_blank) do |attributes|
      Array(attributes[:label]).all?(&:blank?) ||
      Array(attributes[:url]).all?(&:blank?)
    end
  end
end
