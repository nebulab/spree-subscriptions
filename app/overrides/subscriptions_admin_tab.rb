Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'subscriptions_admin_tab',
  insert_bottom: '#main-sidebar',
  partial: 'spree/admin/shared/subscriptions_sidebar_menu'
)
