class Track < ActiveRecord::Base

  KINDS = %w( Bonus Regular )

  validates :album_id, :name, :kind, :lyrics, presence: true
  validates :kind, inclusion: { in: KINDS }

  belongs_to :album

  has_many :notes, dependent: :destroy
  
end
