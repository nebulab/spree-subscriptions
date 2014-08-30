Spree::Admin::UsersController.class_eval do
  def subscriptions
    params[:q] ||= {}
    @search = Spree::Subscription.ransack(params[:q].merge(user_id_eq: @user.id))
    @subscriptions = @search.result.page(params[:page]).per(Spree::Config[:admin_products_per_page])
  end
end
