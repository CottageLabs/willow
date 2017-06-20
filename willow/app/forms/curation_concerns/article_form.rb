# Generated via
#  `rails generate curation_concerns:work Article`
module CurationConcerns
  class ArticleForm < Sufia::Forms::WorkForm
    self.model_class = ::Article
    self.terms += [:resource_type]

  end
end
