class Note < ActiveRecord::Base
  validates :track_id, :author_id, :body, presence: true

  belongs_to :track

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id
  )
end
