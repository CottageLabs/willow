# Generated via
#  `rails generate curation_concerns:work MyWorkType`

module CurationConcerns
  class MyWorkTypesController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior

    self.curation_concern_type = MyWorkType
  end
end
