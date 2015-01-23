class Album < ActiveRecord::Base

  STYLES = %w( Studio Live)

  validates :band_id, :style, presence: true
  validates :style, inclusion: { in: STYLES }

  belongs_to :band

  has_many :tracks, dependent: :destroy

end
