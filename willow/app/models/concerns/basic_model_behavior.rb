module BasicModelBehavior
  extend ActiveSupport::Concern
  include Hyrax::HumanReadableType
  include Hyrax::Noid
  include Hyrax::Permissions
  include Hyrax::Serializers
  include Hydra::WithDepositor
  include Solrizer::Common
  include Hyrax::HasRepresentative
  include Hyrax::Naming
  include Hyrax::CoreMetadata
  include GlobalID::Identification
  include Hyrax::Suppressible
  include Hyrax::WithEvents

  included do
    property :owner, predicate: RDF::URI.new('http://opaquenamespace.org/ns/hydra/owner'), multiple: false
    class_attribute :human_readable_short_description
  end

  # TODO: Move this into ActiveFedora
  def etag
    raise "Unable to produce an etag for a unsaved object" unless persisted?
    ldp_source.head.etag
  end

  module ClassMethods
    # This governs which partial to draw when you render this type of object
    def _to_partial_path #:nodoc:
      @_to_partial_path ||= begin
        element = ActiveSupport::Inflector.underscore(ActiveSupport::Inflector.demodulize(name))
        collection = ActiveSupport::Inflector.tableize(name)
        "hyrax/#{collection}/#{element}".freeze
      end
    end
  end
end
