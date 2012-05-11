Spree::UsersController.class_eval do 
  before_filter :include_user_subscriptions, :only => :show

  private
  def include_user_subscriptions
    @subscriptions = Spree::Subscription.find(:all, :conditions => { :email => @user.email })
  end
end
