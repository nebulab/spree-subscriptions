require 'spec_helper'

describe "Variants" do
  context "setting a variant as subscribabale" do
    before do
      user = create(:admin_user, :email => "test@example.com")
      sign_in_as!(user)
    end

    it "should be markable as subscribable by admin users" do
      product = create(:product_with_option_types, :subscribable => true)

      product.options.each do |option|
        create(:option_value, :option_type => option.option_type)
      end

      visit spree.admin_path
      click_link "Products"
      within('table.index tr:nth-child(2)') { click_link "Edit" }
      click_link "Variants"
      click_on "New Variant"
      page.has_checked_field?('variant_subscribable').should == true
    end
  end
end
