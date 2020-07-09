Rails.application.routes.draw do

  # this goes to the api
  get 'trails/:latitude/:longitude', to: 'trails#for_coords', constraints: { :latitude => /[^\/]+/, :longitude => /[^\/]+/ }

  resources :trails
end
