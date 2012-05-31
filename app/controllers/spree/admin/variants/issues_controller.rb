module Spree
  module Admin
    module Variants
      class IssuesController < Spree::Admin::BaseController
        before_filter :load_variant

        private

        def load_variant
          @variant = Variant.find_by_id(params[:variant_id])
        end
      end
    end
  end
end