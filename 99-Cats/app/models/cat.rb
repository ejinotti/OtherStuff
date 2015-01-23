class Cat < ActiveRecord::Base
  COLORS = %w(brown black gray white orange purple pink)

  validates :birth_date, :name, :description, :user_id, :presence => true
  validates :color, :presence => true, :inclusion => { :in => COLORS }
  validates :sex, :presence => true, :inclusion => { :in => ["M", "F"] }

  has_many :cat_rental_requests, :dependent => :destroy

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  def self.COLORS
    COLORS
  end

  def age
    seconds_old = (0.days.ago - self.birth_date.to_datetime).to_i

    if (seconds_old / 1.year.to_i) == 0
      ((seconds_old % 1.year.to_i) / 1.month.to_i).to_s + " months"
    else
      (seconds_old / 1.year.to_i).to_s + " years"
    end
  end

end
