# Generated via
#  `rails generate curation_concerns:work Article`

module CurationConcerns
  class ArticlesController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior
    # Adds Sufia work notifications to the controller
    include Sufia::Notifications::Work

    self.curation_concern_type = Article
    self.show_presenter = ArticlePresenter
  end
end
