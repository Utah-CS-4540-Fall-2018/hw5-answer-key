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

require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
