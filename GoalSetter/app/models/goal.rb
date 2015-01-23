class Goal < ActiveRecord::Base
  include Commentable
  
  validates :user_id, :objective, presence: true
  validates :privacy, :completed, inclusion: { in: [true, false] }

  belongs_to :user
end
