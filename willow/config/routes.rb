Rails.application.routes.draw do
  
  mount Blacklight::Engine => '/'
  
    concern :searchable, Blacklight::Routes::Searchable.new

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :searchable
  end

  devise_for :users
  mount Hydra::RoleManagement::Engine => '/'

  mount Qa::Engine => '/authorities'
  mount Hyrax::Engine, at: '/'
  resources :welcome, only: 'index'
  root 'hyrax/homepage#index'
  curation_concerns_basic_routes
  concern :exportable, Blacklight::Routes::Exportable.new

  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :exportable
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Add in routes for disabled content types to prevent rails errors in the featured content list
  [Image, Article, Book, Dataset, RdssDataset].each do |content_type|
    # If the content type is disabled, add in the url helper for hyrax_<type>_url
    # This is to prevent rails errors in the featured content list if there is existing content
    # The link to the content will render but lead to a 404 if followed
    unless content_type.content_type_enabled?
      get "disabled_content_type", to: redirect('404'), as: "hyrax_#{content_type.name.underscore}"
    end
  end
end

# Used to generate URLs in libraries that do not have access to the Rails request pipeline. The same settings
# are used for email generation.
Rails.application.routes.default_url_options[:host] = ENV['DEFAULT_URL_OPTIONS_HOST'] || 'localhost'
Rails.application.routes.default_url_options[:protocol] = ENV['DEFAULT_URL_OPTIONS_PROTOCOL'] || 'http'
