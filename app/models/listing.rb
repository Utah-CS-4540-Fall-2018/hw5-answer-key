# == Schema Information
#
# Table name: listings
#
#  id               :integer          not null, primary key
#  description      :text
#  price            :float
#  pricing          :string
#  title            :string
#  url              :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  listings_poll_id :integer
#
# Indexes
#
#  index_listings_on_listings_poll_id  (listings_poll_id)
#

class Listing < ApplicationRecord
  has_many :listing_searches
  has_many :searches, through: :listing_searches
  has_many :users, through: :searches  

  # one way of doing the scopes...
  scope :low_cost,    -> { where(price: 0..99.99) }
  scope :medium_cost, -> { where(price: 100..499.99) }
  scope :high_cost,   -> { where(price: 500..Float::INFINITY) }

  # ...and another way.
  # scope :low_cost,    -> { where("price >= ? and price < ?", 0, 100) }
  # scope :medium_cost, -> { where("price >= ? and price < ?", 100, 500) }
  # scope :high_cost,   -> { where("price >= ?", 500) }


end
