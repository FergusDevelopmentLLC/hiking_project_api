Rails.application.routes.draw do

  get '/', to: 'application#welcome' 

  get '/hiking_project', to: redirect('/map/index.html')

  resources :cities_trails

  resources :cities do
    resources :trails
  end

  resources :trails do
    resources :cities
  end
  get 'cities/:slug/:state_abbrev/trails', to: 'trails#for_cityslug_state'

  # this goes to the api
  get 'trails/:latitude/:longitude/:max_distance/:max_results', to: 'trails#for_coords', constraints: { 
    :latitude => /[^\/]+/, 
    :longitude => /[^\/]+/,
    :max_distance => /[^\/]+/,
    :max_results => /[^\/]+/,
  }



end
