Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :subscriptions
  end
end
