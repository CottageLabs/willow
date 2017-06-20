# Generated via
#  `rails generate curation_concerns:work Article`

module CurationConcerns
  class ArticlesController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior

    self.curation_concern_type = Article
  end
end
