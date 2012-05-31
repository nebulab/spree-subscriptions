module Spree
  module Admin
    module Variants
      class IssuesController < Spree::Admin::BaseController
        before_filter :load_magazine

        def index 
          @issues = Issue.where(:magazine_id => @magazine.id)
        end

        private

        def load_magazine
          @magazine = Variant.find_by_id(params[:magazine_id])
        end
      end
    end
  end
end