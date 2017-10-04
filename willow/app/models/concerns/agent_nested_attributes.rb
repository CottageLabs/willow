# accepts_nested_attributes_for can not be called until all the properties are declared
# because it calls resource_class, which finalizes the propery declarations
# See https://github.com/projecthydra/active_fedora/issues/847
module AgentNestedAttributes
  extend ActiveSupport::Concern
  included do
    id_blank = proc { |attributes| attributes[:id].blank? }

    accepts_nested_attributes_for :identifier_nested, reject_if: :identifier_blank, allow_destroy: true
    accepts_nested_attributes_for :contact_nested, reject_if: :contact_blank, allow_destroy: true

    # identifier_blank - need identifier and scheme attributes
    resource_class.send(:define_method, :identifier_blank) do |attributes|
      (Array(attributes[:obj_id]).all?(&:blank?) ||
       Array(attributes[:obj_id_scheme]).all?(&:blank?))
    end

    # contact_blank - similar to all_blank for defined contact attributes
    resource_class.send(:define_method, :contact_blank) do |attributes|
      contact_attributes.all? do |key|
        Array(attributes[key]).all?(&:blank?)
      end
    end

    resource_class.send(:define_method, :contact_attributes) do
      [:email, :address, :telephone]
    end

  end
end
