module Spree
  module Admin
    module Subscriptions
      class CustomerDetailsController < Spree::Admin::BaseController
        before_filter :load_subscription

        def show
          edit
          render action: :edit
        end

        def edit
          @subscription.build_ship_address(country_id: Spree::Config[:default_country_id]) if @subscription.ship_address.nil?
        end

        def update
          if @subscription.update_attributes(customer_params)
            flash[:notice] = Spree.t('customer_details_updated')
            redirect_to edit_admin_subscription_path(@subscription)
          else
            render action: :edit
          end
        end

        private

        def load_subscription
          @subscription = Subscription.find(params[:subscription_id])
        end

        def customer_params
          params.require(:subscription).
            permit(:email, ship_address_attributes: [
                :firstname,
                :lastname,
                :address1,
                :address2,
                :city,
                :zipcode,
                :state_id,
                :country_id,
                :phone,
                :id
              ]
            )
        end
      end
    end
  end
end
