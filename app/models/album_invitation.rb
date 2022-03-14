# == Schema Information
#
# Table name: album_invitations
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :integer
#  member_id  :integer
#  owner_id   :integer
#
class AlbumInvitation < ApplicationRecord
  # Direct associations
  belongs_to(:owner, { :class_name => "User" })
  belongs_to(:member, { :class_name => "User" })
  belongs_to(:album)

  # Validations
  validates(:owner_id, { :presence => true })
  validates(:member_id, { :presence => true })
  validates(:album_id, { :presence => true })
  validates(:album_id, { :uniqueness => { :scope => ["member_id", "owner_id"] } })
  
end
