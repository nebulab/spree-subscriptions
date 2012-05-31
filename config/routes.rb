Spree::Core::Engine.routes.prepend do
  namespace :admin do
    resources :subscriptions do
      resource :customer, :controller => "subscriptions/customer_details"
    end
    resources :variants do
      resources :issues, :controller => "variants/issues"
    end
  end
end
