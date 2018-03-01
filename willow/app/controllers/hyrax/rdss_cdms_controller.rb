# Generated via
#  `rails generate hyrax:work RdssCdm`

module Hyrax
  class RdssCdmsController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    # Adds Hyrax work notifications to the controller
    self.curation_concern_type = ::RdssCdm

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::RdssCdmPresenter
  end
end
