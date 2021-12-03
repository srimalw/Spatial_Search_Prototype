Rails.application.routes.draw do
  apipie
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'


  namespace :api do
    namespace :v1 do
      get 'geoJson/lat_lng_details' => 'geo_location#index', :defaults => { format: 'json' }
    end
  end
end
