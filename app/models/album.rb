# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :integer
#
class Album < ApplicationRecord
  # Direct associations
  belongs_to(:owner, { :class_name => "User" })
  has_many(:photos, { :dependent => :destroy })
  has_many(:album_invitations_to_members, { :class_name => "AlbumInvitation", :dependent => :destroy })

  # Indirect associations
  has_many(:members, { :through => :album_invitations_to_members, :source => :member })

  # Validations
  validates(:title, { :presence => true })
  validates(:title, { :uniqueness => { :scope => ["owner_id"] } })
  validates(:owner_id, { :presence => true })
  
end
