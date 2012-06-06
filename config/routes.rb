Spree::Core::Engine.routes.prepend do
  namespace :admin do
    resources :subscriptions do
      resource :customer, :controller => "subscriptions/customer_details"
    end
    resources :products, :as => :magazines do
      resources :issues, :controller => "products/issues"
    end
  end
end
