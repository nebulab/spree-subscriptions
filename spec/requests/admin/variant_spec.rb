require 'spec_helper'

describe "Variant" do
  context "setting issues number" do
    before do
      @subscribable_product = create(:product, subscribable: true)
      @variant1, @variant2 = create_variants_for(@subscribable_product)
      user = create(:admin_user, email: "test@example.com")
      sign_in_as!(user)
    end

    it "should have issue number field if subscribable" do
      visit spree.admin_path
      click_link "Products"
      within('[data-hook="admin_product_sub_tabs"]') { click_link 'Products' }
      within('table#listing_products tbody tr:nth-child(1)') { click_icon('edit') }
      click_link "Variants"
      within('table.table.sortable tbody tr:nth-child(1)') { click_icon('edit') }
      fill_in "Issues number", with: "24"
      click_button "Update"
      page.should have_content "successfully updated"
    end

    it "should not have issue number field if not subscribable" do
      product = create(:product)
      create(:variant, product: product)
      create(:variant, product: product)
      visit spree.admin_path
      click_link "Products"
      within('[data-hook="admin_product_sub_tabs"]') { click_link 'Products' }
      within("table#listing_products tbody tr#spree_product_#{product.id}") { click_icon('edit') }
      click_link "Variants"
      within('table.table.sortable tbody tr:nth-child(1)') { click_icon('edit') }
      page.should_not have_content "Issues number"
    end
  end
end
