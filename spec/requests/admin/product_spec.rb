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

    it "should not have issue tab if product is not subscribable" do
      create(:simple_product)
      visit spree.admin_path
      click_link "Products"
      within('table.index tr:nth-child(2)') { click_link "Edit" }
      page.should_not have_content("Issues")
    end 

    it "should let add an issue to a subscribable product" do
      create(:simple_product, :subscribable => true)

      visit spree.admin_path
      click_link "Products"
      within('table.index tr:nth-child(2)') { click_link "Edit" }
      page.should have_content("Issues")
      click_link "Issues"
      page.should have_content("Listing Issues")
    end
  end
end
