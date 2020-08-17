Rails.application.routes.draw do

  get '/hiking_project', to: redirect('/map/index.html')

  resources :cities_trails

  get 'cities/:slug/:state_abbrev', to: 'cities#show'
  resources :cities do
    resources :trails
  end

  get 'cities/:slug/:state_abbrev/trails', to: 'trails#for_city'
  resources :trails do
    resources :cities
  end

  # this goes to the api
  get 'trails/:latitude/:longitude/:max_distance/:max_results', to: 'trails#for_coords', constraints: { 
    :latitude => /[^\/]+/, 
    :longitude => /[^\/]+/,
    :max_distance => /[^\/]+/,
    :max_results => /[^\/]+/,
  }

end
