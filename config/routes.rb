Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :subscriptions do
      resource :customer, controller: "subscriptions/customer_details"
    end

    resources :products, as: :magazines do
      resources :issues, controller: "products/issues"
      match "issues/:id/ship", to: "products/issues#ship", via: :get, as: :issue_ship
      match "issues/:id/unship", to: "products/issues#unship", via: :get, as: :issue_unship
    end

    resources :users do
      member do
        get :subscriptions
      end
    end
  end
end
