Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, as: nil do
    namespace :v1, as: nil do |version|
      resources :events
      resources :rooms
    end
  end

  match '*unmatched_route', :to => 'application#raise_not_found', :via => [:get, :post, :patch, :delete]
end
