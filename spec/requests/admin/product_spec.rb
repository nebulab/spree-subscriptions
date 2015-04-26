require 'spec_helper'

describe "Products" do
  context "setting a product as subscribabale" do
    before do
      user = create(:admin_user, email: "test@example.com")
      sign_in_as!(user)
    end

    it "should be markable as subscribable by admin users" do
      product = create(:product_with_option_types)

      product.options.each do |option|
        create(:option_value, option_type: option.option_type)
      end

      visit spree.admin_path
      click_link "Products"
      within('[data-hook="admin_product_sub_tabs"]') { click_link 'Products' }
      within('table#listing_products tbody tr:nth-child(1)') { click_icon('edit') }
      check('product_subscribable')
      click_button "Update"
      page.should have_content("successfully updated!")
      page.has_checked_field?('product_subscribable').should == true
    end

    it "should not let choose issues number for unsuscribable product" do
      product = create(:base_product)

      visit spree.admin_path
      click_link "Products"
      within('[data-hook="admin_product_sub_tabs"]') { click_link 'Products' }
      within('table#listing_products tbody tr:nth-child(1)') { click_icon('edit') }
      page.should_not have_content "Issues number"
    end

    it "should let choose the issues number" do
      product = create(:base_product, subscribable: true)

      visit spree.admin_path
      click_link "Products"
      within('[data-hook="admin_product_sub_tabs"]') { click_link 'Products' }
      within('table#listing_products tbody tr:nth-child(1)') { click_icon('edit') }
      fill_in "Issues number", with: "4"
      click_button "Update"
      page.should have_content("successfully updated!")
      find_field("Issues number").value.should == "4"
    end
  end
end
