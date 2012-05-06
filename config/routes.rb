Spree::Core::Engine.routes.prepend do
  namespace :admin do
    resources :subscriptions
  end
end
