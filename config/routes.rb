Rails.application.routes.draw do

  get 'trails/:latitude/:longitude', to: 'trails#for_coords', constraints: { :latitude => /[^\/]+/, :longitude => /[^\/]+/ }

  resources :trails
end
