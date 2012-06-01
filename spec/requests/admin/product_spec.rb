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

    context "accessing product issues" do
      context "unsuscribable products" do
        it "should not have issue tab" do
          create(:simple_product)
          visit spree.admin_path
          click_link "Products"
          within('table.index tr:nth-child(2)') { click_link "Edit" }
          page.should_not have_content("Issues")
        end
      end

      context "subscribable products" do
        before(:each) do
          @magazine = create(:simple_product, :subscribable => true).master
          visit spree.admin_path
          click_link "Products"
          within('table.index tr:nth-child(2)') { click_link "Edit" }
        end

        it "should have issue tab" do
          page.should have_content("Issues")
        end

        it "should let view product issues" do
          issue = create(:issue, :magazine => @magazine)
          click_link "Issues"
          page.should have_content("Listing Issues")
          page.should have_content(issue.name)
        end
      end
    end
  end
end
