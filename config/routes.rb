Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, as: nil do
    namespace :v1, as: nil do |version|
      devise_for :users, controllers: { sessions: "api/v1/sessions" }, defaults: { format: :json }

      resources :rooms
      resources :events
    end
  end

  match '*unmatched_route', :to => 'application#raise_not_found', :via => [:get, :post, :patch, :delete]
end
