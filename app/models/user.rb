require 'openssl'

class User < ApplicationRecord
  REGEXP_USERNAME = /\A\w+\z/
  ITERATION = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  attr_accessor :password

  has_many :questions, dependent: :destroy
  has_many :author_questions, class_name: 'Question', foreign_key: :author_id, dependent: :nullify
  
  before_validation :downcase_email_username
  before_save :encrypt_password

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true

  validates :username,
            length: { maximum: 40 },
            format: { with: REGEXP_USERNAME }
  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, confirmation: true
  validates :password, presence: true, on: :create

  validates :color_background_user, format: { with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/ }

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email&.downcase)

    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATION, DIGEST.length, DIGEST))
      user
    end
  end

  private

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATION, DIGEST.length, DIGEST)
      )
    end
  end

  def downcase_email_username
    username&.downcase!
    email&.downcase!
  end
end