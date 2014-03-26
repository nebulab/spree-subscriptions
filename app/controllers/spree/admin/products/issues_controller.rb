module Spree
  module Admin
    module Products
      class IssuesController < Spree::Admin::BaseController
        before_filter :load_magazine
        before_filter :load_issue, :only => [:show, :edit, :update, :ship]
        before_filter :load_products, :except => [:show, :index]

        def show
          if @issue.shipped?
            @product_subscriptions = @issue.shipped_issues.map { |shipped_issue| shipped_issue.subscription }.compact
          else
            @product_subscriptions = Subscription.eligible_for_shipping.where(:magazine_id => @magazine.id)
          end
          respond_to do |format|
            format.html
            format.pdf do
              addresses_list = @product_subscriptions.map { |s| s.ship_address }
              labels = IssuePdf.new(addresses_list, view_context)
              send_data labels.document.render, :filename => "#{@issue.name}.pdf", :type => "application/pdf", disposition: "inline"
            end
          end
        end

        def index
          @issues = Issue.where(:magazine_id => @magazine.id)
        end

        def update
          if @issue.update_attributes(issue_params)
            flash[:notice] = t('issue_updated')
            redirect_to admin_magazine_issue_path(@magazine, @issue)
          else
            flash[:error] = t(:issue_not_updated)
            render :action => :edit
          end
        end

        def new
          @issue = @magazine.issues.build
        end

        def create
          if (new_issue = @magazine.issues.create(issue_params))
            flash[:notice] = t('issue_created')
            redirect_to admin_magazine_issue_path(@magazine, new_issue)
          else
            flash[:error] = t(:issue_not_created)
            render :new
          end
        end

        def ship
          if @issue.shipped?
            flash[:error]  = t('issue_not_shipped')
          else
            @issue.ship!
            flash[:notice]  = t('issue_shipped')
          end
          redirect_to admin_magazine_issues_path(@magazine, @issue)
        end

        private

        def load_magazine
          @magazine = Product.find_by_permalink(params[:magazine_id])
          @product = @magazine # useful to display product_tab menu
        end

        def load_issue
          @issue = Issue.find(params[:id])
        end

        def load_products
          @products = Product.unsubscribable.map { |product| [product.name, product.id] }
        end

        def issue_params
          params.require(:issue).permit(:name, :published_at, :shipped_at, :magazine, :magazine_issue_id)
        end
      end
    end
  end
end
