Rails.application.routes.draw do

  resources :cities
  resources :trails

  # this goes to the api
  get 'trails/:latitude/:longitude/:max_distance/:max_results', to: 'trails#for_coords', constraints: { 
    :latitude => /[^\/]+/, 
    :longitude => /[^\/]+/,
    :max_distance => /[^\/]+/,
    :max_results => /[^\/]+/,
  }

end
