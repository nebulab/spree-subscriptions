module Spree
  module Admin
    class SubscriptionsController < ResourceController
      before_filter :load_data, except: :index

      def show
        redirect_to( action: :edit )
      end

      def index
        params[:q] ||= {}
        @search = Subscription.search(params[:q])
        @subscriptions = @search.result.page(params[:page]).per(15)
      end

      def create
        create_or_update Spree.t("subscription_successfully_created")
      end

      def update
        create_or_update Spree.t("subscription_successfully_updated")
      end

      protected

      def load_data
        @products = Product.subscribable.all.map { |product| [product.name, product.id] }
      end

      private

      def create_or_update(flash_msg)
        if @subscription.update_attributes(subscription_params)
          redirect_to edit_admin_subscription_path(@subscription)
          flash.notice = flash_msg
        else
          respond_with(@subscription)
        end
      end

      def subscription_params
        params.require(:subscription).permit(:email, :magazine_id, :remaining_issues, :ship_address_attributes, :ship_address)
      end
    end
  end
end
