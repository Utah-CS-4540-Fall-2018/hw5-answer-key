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
  belongs_to :listings_poll
  has_many :listing_searches
  has_many :searches, through: :listing_searches
end
