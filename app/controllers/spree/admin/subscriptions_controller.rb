module Spree
  module Admin
    class SubscriptionsController < ResourceController
      before_filter :load_data, :except => :index

      def index
        @search = Subscription.search()
        @subscriptions = @search.result.page(params[:page]).per(10)
      end

      protected

      def load_data
        @variants = Variant.subscribable.all.map { |variant| [variant.product.name, variant.id] }
      end
    end
  end
end
