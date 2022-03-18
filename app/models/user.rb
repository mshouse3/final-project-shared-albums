# == Schema Information
#
# Table name: users
#
#  id                             :integer          not null, primary key
#  email                          :string
#  own_photos_count               :integer
#  password_digest                :string
#  received_follow_requests_count :integer
#  sent_follow_requests_count     :integer
#  username                       :string
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  # Direct associations
  has_many(:likes, { :dependent => :destroy })
  has_many(:comments, { :foreign_key => "commenter_id", :dependent => :destroy })
  has_many(:sent_follow_requests, { :class_name => "FriendRequest", :foreign_key => "sender_id", :dependent => :destroy })
  has_many(:received_follow_requests, { :class_name => "FriendRequest", :foreign_key => "recipient_id", :dependent => :destroy })
  has_many(:own_photos, { :class_name => "Photo", :foreign_key => "owner_id", :dependent => :destroy })
  has_many(:own_albums, { :class_name => "Album", :foreign_key => "owner_id", :dependent => :destroy })
  has_many(:album_sent_invites, { :class_name => "AlbumInvitation", :foreign_key => "owner_id", :dependent => :destroy })
  has_many(:album_received_invites, { :class_name => "AlbumInvitation", :foreign_key => "member_id", :dependent => :destroy })

  # Indirect Associations
  has_many(:following, { :through => :sent_follow_requests, :source => :recipient })
  has_many(:followers, { :through => :received_follow_requests, :source => :sender })
  has_many(:liked_photos, { :through => :likes, :source => :photo })
  has_many(:albums, { :through => :album_received_invites, :source => :album })
  has_many(:feed, { :through => :following, :source => :own_photos })
  has_many(:activity, { :through => :following, :source => :liked_photos })


  # Validations
  validates(:username, { :presence => true })
  validates(:username, { :uniqueness => true })
  
end
