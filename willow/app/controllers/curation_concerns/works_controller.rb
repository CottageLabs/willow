# Generated via
#  `rails generate curation_concerns:work Work`

module CurationConcerns
  class WorksController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior
    # Adds Sufia work notifications to the controller
    include Sufia::Notifications::Notifiers

    self.curation_concern_type = ::Work
  end
end
