# This initializer adds functionality to the hyrax gem class
# Hyrax::SelectTypeListPresenter
# This allows us to filter the modal for adding a new work and not include disabled content types
Hyrax::SelectTypeListPresenter.class_eval do
    
    # redefine Hyrax::SelectTypeListPresenter#each
    # so that it only yields a presenter for 
    # content types that are not disabled
    # original source is here
    # https://github.com/CottageLabs/hyrax/blob/master/app/presenters/hyrax/select_type_list_presenter.rb#L33
    def each
      # authorized_models is an array of classes for the registered model types
      # => [Article, Image, Book, Dataset, RdssDataset]
      authorized_models.each do |model|
        # only yield the presenter if new content of the content type is not disabled
        unless model.new_content_of_type_disabled?
          yield row_presenter.new(model)
        end
      end
    end
end