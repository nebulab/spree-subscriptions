module Spree
  Variant.class_eval do
    before_save :set_default_isssues_number

    delegate :subscribable?, to: :product

    def set_default_isssues_number
      self.issues_number = Spree::Subscriptions::Config.default_issues_number if !self.issues_number
    end
  end
end
