# Generated via
#  `rails generate curation_concerns:work Dataset`

class Dataset < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include ::CurationConcerns::BasicMetadata
  include Sufia::WorkBehavior
  self.human_readable_type = 'Dataset'
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  property :license, predicate: ::RDF::Vocab::DC.license, class_name:"LicenseStatement" do |index|
    index.as :stored_searchable, :facetable, using: :pref_label
  end

  # must be included after all properties are declared
  include NestedAttributes

end
