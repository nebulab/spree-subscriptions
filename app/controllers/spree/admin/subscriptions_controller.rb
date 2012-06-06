module Spree
  module Admin
    class SubscriptionsController < ResourceController
      before_filter :load_data, :except => :index

      def show
        redirect_to( :action => :edit )
      end

      def index
        @search = Subscription.search()
        @subscriptions = @search.result.page(params[:page]).per(10)
      end

      def create
        if @subscription.update_attributes(params[:subscription])
          redirect_to edit_admin_subscription_customer_path(@subscription)
          flash.notice = t("subscription successfully created!")
        else
          respond_with(@subscription)
        end
      end
      
      def update
        if @subscription.update_attributes(params[:subscription])
          redirect_to edit_admin_subscription_path(@subscription)
          flash.notice = t("subscription successfully updated!")
        else
          respond_with(@subscription)
        end
      end

      protected

      def load_data
        @products = Product.subscribable.all.map { |product| [product.name, product.id] }
      end
    end
  end
end
