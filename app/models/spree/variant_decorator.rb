module Spree
  Variant.class_eval do
    attr_accessible :issues_number

    before_save :set_default_isssues_number

    def set_default_isssues_number
      self.issues_number = Spree::Subscriptions::Config.default_issues_number if !self.issues_number      
    end
  end
end