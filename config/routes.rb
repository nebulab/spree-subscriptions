Spree::Core::Engine.routes.prepend do
  namespace :admin do
    resources :subscriptions do
     resource :customer, :controller => "subscriptions/customer_details"
    end
  end
end
