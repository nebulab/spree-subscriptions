require 'spec_helper'

describe 'Issue' do
  context 'as_admin_user' do
    let!(:user) { create(:admin_user, email: 'test@example.com') }

    before do
      create(:store)
      sign_in_as!(user)
      visit spree.admin_path
    end

    context 'accessing product issues' do
      context 'unsuscribable products' do
        let!(:base_product) { create(:base_product) }

        it 'should not have issue tab' do
          click_link 'Products'

          within('[data-hook="admin_product_sub_tabs"]') do
            click_link 'Products'
          end

          within('table#listing_products tbody tr:nth-child(1)') do
            click_link base_product.name
          end

          page.should_not have_content('Issues')
        end
      end

      context 'subscribable products' do
        let!(:magazine) { create(:subscribable_product) }

        before(:each) do
          click_link 'Products'

          within('[data-hook="admin_product_sub_tabs"]') do
            click_link 'Products'
          end

          within('table#listing_products tbody tr:nth-child(1)') do
            click_link magazine.name
          end
        end

        it 'should have issue tab' do
          page.should have_link('Issues')
        end

        it 'should let view product issues' do
          issue       = create(:issue, magazine: magazine)
          other_issue = create(:issue)

          click_link 'Issues'

          page.should have_content('Available issues')
          page.should have_content(issue.name)
          page.should_not have_content(other_issue.name)
        end
      end
    end

    context 'managing an issue' do
      let!(:product_issue) { create(:product, name: 'Issue number 4') }
      let!(:magazine) { create(:subscribable_product) }

      before do
        visit spree.edit_admin_product_path magazine
      end

      context 'creating an issue' do
        it 'should let access the new issue page' do
          click_link 'Issues'
          click_link 'New issue'
        end

        it 'should create a new issue without associated product' do
          click_link 'Issues'
          click_link 'New issue'
          fill_in 'Name', with: 'Magazine issue number 4'
          click_button 'Create'
          within('[data-hook=admin_product_issue_header]') do
            page.should have_content 'Magazine issue number 4'
          end
        end

        it 'should create a new issue with an associated product' do
          click_link 'Issues'
          click_link 'New issue'

          within('[data-hook=admin_product_issue_new_form]') do
            select2_search 'Issue number 4', from: 'Product'
          end

          click_button 'Create'
          Spree::Issue.last.magazine_issue.name == 'Issue number 4'
        end

        it 'should not let select subscribable product as associated product' do
          click_link 'Issues'
          click_link 'New issue'

          page.should have_xpath(
            "//*[@id='issue_magazine_issue_id']/option",
            count: 2
          )
        end
      end

      context 'editing a product issue' do
        let!(:issue) { create(:issue, magazine: magazine) }

        before do
          click_link 'Issues'
          within('table.index#listing_issues tbody tr:nth-child(1)') do
            find('.edit').click
          end
        end

        it 'shoud let access the edit issue page' do
          find_field('issue_name').value.should == issue.name
        end

        it 'should let update an issue' do
          fill_in 'Name', with: 'Magazine issue number 4'
          click_button 'Update'

          page.should have_content 'Issue updated!'
          page.should have_content 'Magazine issue number 4'
        end
      end

      context 'showing a product issue' do
        let!(:issue) { create(:issue, magazine: magazine) }
        let!(:subscription) { create(:ending_subscription, magazine: magazine) }

        it 'should display the list of subscribers' do
          click_link 'Issues'
          within('table.index#listing_issues tbody tr:nth-child(1)') do
            click_link issue.name
          end

          page.should have_content subscription.email
        end

        it 'should display only users subscribed to that issue' do
          other_magazine = create(:subscribable_product)
          other_subscription = create :ending_subscription,
                                      magazine: other_magazine,
                                      email: 'other@email.com'

          click_link 'Issues'
          within('table.index#listing_issues tbody tr:nth-child(1)') do
            click_link issue.name
          end

          page.should_not have_content other_subscription.email
        end

        it 'should display only users that have remaining issues' do
          other_magazine = create(:subscribable_product)
          other_subscription = create :ending_subscription,
                                      magazine: other_magazine,
                                      email: 'other@email.com'

          click_link 'Issues'
          within('table.index#listing_issues tbody tr:nth-child(1)') do
            click_link issue.name
          end

          page.should_not have_content other_subscription.email
        end

        context 'shipping an issue' do
          before do
            Spree::Subscriptions::Config.use_delayed_job = false
            (0..5).each { create(:ending_subscription, magazine: magazine) }
          end

          it 'should show listing as "subscribed"' do
            click_link 'Issues'
            within('table.index#listing_issues tbody tr:nth-child(1)') do
              click_link issue.name
            end

            page.should have_content 'Subscribed'
          end

          it 'should see the delete button' do
            click_link 'Issues'

            page.should have_icon('trash')
          end

          it 'should be markable as shipped' do
            click_link 'Issues'
            within('table.index#listing_issues tbody tr:nth-child(1)') do
              click_link issue.name
            end

            click_link Spree.t(:ship)

            page.should have_content 'successfully shipped'
            page.should_not have_icon('trash')
            page.should have_icon('history')
          end

          context 'after issue is shipped' do
            before do
              issue.ship!
              (0..5).each { create(:ending_subscription, magazine: magazine) }

              click_link 'Issues'
              within('table.index#listing_issues tbody tr:nth-child(1)') do
                click_link issue.name
              end
            end

            it 'should not see the ship button' do
              click_link 'Issues'
              page.should_not have_icon('truck')
            end

            it 'should not see the delete button' do
              click_link 'Issues'
              page.should_not have_icon('delete')
            end

            it 'should show listing as "shipped to"' do
              page.should have_content 'Shipped to'
            end

            it 'should display the list of user that received the issue' do
              page.should have_selector(
                'table#subscriptions_listing tbody tr',
                count: issue.shipped_issues.count
              )
            end

            context 'unshipping an issue' do
              it 'should display the unship button' do
                page.should have_link 'Unship'
              end

              it 'should show listing as "subscribed"' do
                click_link 'Issues'
                within('table.index#listing_issues tbody tr:nth-child(1)') do
                  click_link issue.name
                end
                page.should have_link 'Unship'
                click_link 'Unship'
                page.should have_content 'successfully unshipped'

                within('table.index#listing_issues tbody tr:nth-child(1)') do
                  click_link issue.name
                end

                page.should_not have_link 'Unship'
                page.should have_link 'Ship'
                page.should_not have_content 'Shipped to'
                page.should have_content 'Subscribed'
                page.should have_button 'Delete'

                click_button 'Delete'
                page.should have_content 'Issue Deleted'
              end
            end

            context 'unshipping an issue' do
              it 'should display the unship button' do
                page.should have_link 'Unship'
              end

              it 'should show listing as "subscribed"' do
                click_link 'Issues'
                within('table.index#listing_issues tbody tr:nth-child(1)') do
                  click_link issue.name
                end

                page.should have_link 'Unship'
                click_link 'Unship'
                page.should have_content 'successfully unshipped'

                within('table.index#listing_issues tbody tr:nth-child(1)') do
                  click_link issue.name
                end

                page.should_not have_link 'Unship'
                page.should have_link 'Ship'
                page.should_not have_content 'Shipped to'
                page.should have_content 'Subscribed'
                page.should have_button 'Delete'

                click_button 'Delete'
                page.should have_content 'Issue Deleted'
              end
            end
          end
        end
      end
    end
  end
end
