require 'spec_helper'

describe "Products" do
  context "setting a product as subscribabale" do
    before do
      user = create(:admin_user, :email => "test@example.com")
      sign_in_as!(user)
    end

    it "should be markable as subscribable by admin users" do
      product = create(:product_with_option_types)

      product.options.each do |option|
        create(:option_value, :option_type => option.option_type)
      end

      visit spree.admin_path
      click_link "Products"
      within('table.index tr:nth-child(2)') { click_link "Edit" }
      check('product_subscribable')
      click_button "Update"
      page.should have_content("successfully updated!")
      page.has_checked_field?('product_subscribable').should == true
    end
  end
end
