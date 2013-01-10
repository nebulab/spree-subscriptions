Spree::Core::Engine.routes.prepend do
  namespace :admin do
    resources :subscriptions do
      resource :customer, :controller => "subscriptions/customer_details"
    end
    resources :products, :as => :magazines do
      resources :issues, :controller => "products/issues"
      match "issues/:id/ship", :to => "products/issues#ship", :via => :get, :as => :issue_ship
    end
    resources :users # Hack to make tests pass
  end
end