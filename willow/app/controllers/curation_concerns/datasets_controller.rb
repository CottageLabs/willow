# Generated via
#  `rails generate curation_concerns:work Dataset`

module CurationConcerns
  class DatasetsController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior

    self.curation_concern_type = Dataset
    self.show_presenter = DatasetPresenter
  end
end
