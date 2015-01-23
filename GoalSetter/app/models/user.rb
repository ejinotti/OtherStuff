class User < ActiveRecord::Base
  include Commentable

  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  attr_reader :password

  has_many :goals

  has_many(
    :authored_comments,
    class_name: 'Comment',
    foreign_key: :author_id,
    primary_key: :id
  )

  def self.user_cheers_sums
    sql = <<-SQL
      SELECT
        users.username, SUM(goals.cheers) AS cheer_sum
      FROM
        users
      LEFT OUTER JOIN
        goals
      ON
        goals.user_id = users.id
      GROUP BY
        users.username
      ORDER BY
        SUM(goals.cheers) DESC
      LIMIT
        5;
    SQL
    self.connection.execute(sql)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    return nil if user.nil?
    return user if user.is_password?(password)
    nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
