# == Schema Information
#
# Table name: searches
#
#  id         :integer          not null, primary key
#  keywords   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_searches_on_user_id  (user_id)
#

class Search < ApplicationRecord
  belongs_to :user
  has_many :listing_searches
  has_many :listings, through: :listing_searches

  validates :keywords, presence: true
  validates :keywords, uniqueness: { scope: :user_id }
end
