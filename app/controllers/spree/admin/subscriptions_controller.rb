module Spree
  module Admin
    class SubscriptionsController < ResourceController
      respond_to :html

      def index 
        params[:q] ||= {}
        @search = Subscription.search(params[:q])
        @subscriptions = @search.result.includes([:user]).page(params[:page]).per(Spree::Config[:orders_per_page])
        respond_with(@subscriptions)
      end

    end
  end
end
