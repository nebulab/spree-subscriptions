module Spree
  Product.class_eval do
    has_many :issues, dependent: :destroy, foreign_key: "magazine_id"
    has_many :subscriptions, foreign_key: "magazine_id"

    accepts_nested_attributes_for :issues

    delegate_belongs_to :master, :issues_number

    scope :subscribable, -> { where(subscribable: true) }
    scope :unsubscribable, -> { where(subscribable: false) }
  end
end
