module Spree
  module Admin
    module Variants
      class IssuesController < Spree::Admin::BaseController
        before_filter :load_magazine

        def index 
          @issues = Issue.where(:magazine_id => @magazine.id)
        end

        def show
          edit
          render :action => :edit
        end

        def edit
          @issue = Issue.find(params[:id])
        end

        def update
          @issue = Issue.find(params[:id])
          if @issue.update_attributes(params[:issue])          
            flash[:notice] = t('issue_updated')
            redirect_to edit_admin_magazine_issue_path(@magazine, @issue)
          else
            render :action => :edit
          end
        end

        def new
          @issue = Issue.new
        end

        def create
          params[:issue][:magazine] ||= @magazine
          if Issue.create(params[:issue])
            flash[:notice] = t('issue_created')
            redirect_to admin_magazine_issues_path(@magazine)
          else
            render :new
          end
        end

        private

        def load_magazine
          @magazine = Variant.find(params[:magazine_id])
        end
      end
    end
  end
end