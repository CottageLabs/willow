# Generated via
#  `rails generate hyrax:work RdssCdm`
class RdssCdmIndexer < Hyrax::WorkIndexer
  def generate_solr_document
    super.tap do |solr_doc|
      # Enter any manual indexing code here
      # if possible, indexing should be specified within the model
    end
  end
end
