# == Schema Information
#
# Table name: friend_requests
#
#  id           :integer          not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
class FriendRequest < ApplicationRecord
  # Direct associations
  belongs_to(:sender, { :class_name => "User", :counter_cache => :sent_follow_requests_count })
  belongs_to(:recipient, { :class_name => "User", :counter_cache => :received_follow_requests_count })

  # Validations
  validates(:sender_id, { :presence => true })
  validates(:recipient_id, { :presence => true })
  validates(:recipient_id, { :uniqueness => { :scope => ["sender_id"], :message => "already requested" } })
  
end
