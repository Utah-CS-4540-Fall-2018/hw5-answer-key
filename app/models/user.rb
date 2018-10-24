# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :searches
  has_many :listings, through: :searches

  #validates :email, :format, regex...
  validates :first_name, presence: true
  validates :last_name, presence: true  

  validates :email, uniqueness: { message: "Another use is already using that email!" }
  validates :first_name, length: { minimum: 3 }
  validates :last_name, length: { minimum: 2 }

end
