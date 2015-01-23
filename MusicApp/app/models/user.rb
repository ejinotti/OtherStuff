class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many(
    :notes,
    class_name: 'Note',
    foreign_key: :author_id,
    primary_key: :id,
    dependent: :destroy
  )

  has_many(
    :noted_tracks,
    through: :notes,
    source: :track
  )

  attr_reader :password

  def self.generate_token
    SecureRandom::urlsafe_base64
  end

  def self.find_by_creds(email, pw)
    user = User.find_by(email: email)

    return nil if user.nil?

    if user.is_password?(pw)
      user
    else
      nil
    end
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  def reset_token!
    self.session_token = self.class.generate_token
    self.save!
    nil
  end

end
