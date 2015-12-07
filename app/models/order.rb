class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :order_items, allow_destroy: true
  #, reject_if: proc { |attributes| attributes['description'].blank? }
end
