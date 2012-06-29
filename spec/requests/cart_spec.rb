require 'spec_helper'

describe "Cart" do
  context "as_user" do
    let(:product){ Factory(:product) }
    let(:subscribable_product){ Factory(:subscribable_product, :name => "sport magazine") }

    it "has add to cart specific for subscribable products" do
      visit spree.product_path(subscribable_product)

      within(".add-to-cart") do
        page.should have_selector("input", :type => "hidden")
        page.should have_content(I18n.t(:subscribe_call_to_action))
      end
    end

    it "has normal add to cart elements for normal products" do
      visit spree.product_path(product)

      within(".add-to-cart") do
        page.should have_selector("input", :value => "1")
        page.should have_content(I18n.t(:add_to_cart))
      end
    end

    it "has a disabled field for quantity in cart" do
      visit spree.product_path(subscribable_product)
      add_to_cart("sport magazine")
      page.should have_selector("#cart-detail input.line_item_quantity", :disabled => "disabled")
    end

    it "doesn't re-add subscribable products already in cart" do
      visit spree.product_path(subscribable_product)
      add_to_cart("sport magazine")

      visit spree.product_path(subscribable_product)
      add_to_cart("sport magazine")

      page.should have_selector("#cart-detail input.line_item_quantity", :value => "1")
    end
  end
end
