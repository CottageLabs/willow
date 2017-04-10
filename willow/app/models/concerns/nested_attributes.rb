# accepts_nested_attributes_for can not be called until all the properties are declared
# because it calls resource_class, which finalizes the propery declarations
# See https://github.com/projecthydra/active_fedora/issues/847
module NestedAttributes
  extend ActiveSupport::Concern

  included do
    id_blank = proc { |attributes| attributes[:id].blank? }

    accepts_nested_attributes_for :license, reject_if: :license_blank, allow_destroy: true

    resource_class.send(:define_method, :license_blank) do |attributes|
      license_attributes.all? do |key|
        Array(attributes[key]).all?(&:blank?)
      end
    end

    resource_class.send(:define_method, :license_attributes) do
      [:label, :definition, :webpage]
    end
  end
end
