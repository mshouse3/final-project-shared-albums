# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  commenter_id :integer
#  photo_id     :integer
#
class Comment < ApplicationRecord
  # Direct associations
  belongs_to(:commenter, { :class_name => "User" })
  belongs_to(:photo, { :counter_cache => true })

  # Validations
  validates(:photo_id, { :presence => true })
  validates(:commenter_id, { :presence => true })
  validates(:body, { :presence => true })
  
end
