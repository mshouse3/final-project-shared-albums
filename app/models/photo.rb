# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  caption        :string
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  location       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  album_id       :integer
#  owner_id       :integer
#
class Photo < ApplicationRecord
  # Direct Associations
  belongs_to(:owner, { :class_name => "User", :counter_cache => :own_photos_count })
  has_many(:likes, { :dependent => :destroy })
  has_many(:comments, { :dependent => :destroy })
  belongs_to(:album)

  # Indirect associations
  has_many(:fans, { :through => :likes, :source => :user })
  has_many(:followers, { :through => :owner, :source => :following })
  has_many(:fan_followers, { :through => :fans, :source => :following })

  # Validations
  validates(:owner_id, { :presence => true })
  validates(:image, { :presence => true })
  validates(:album_id, { :presence => true })
  
end
