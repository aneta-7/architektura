class User < ApplicationRecord
   has_many :microposts, dependent: :destroy
   attr_accessor :remember_token, :activation_token, :reset_token
   before_save :downcase_email
   before_create :create_activation_digest
   validates :name, presence: true, length: {maximum: 50} 
   validates :email, presence: true, length: {maximum: 50}
   has_secure_password
   validates :password, presence: true, length: { minimum: 6}, allow_nil: true
class << self
 def digest(string)
 	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
 end

 def new_token
    SecureRandom.urlsafe_base64
 end
end
 def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
 end
 
 def authenticated?(remember_token)
  return false if remember_digest.nil?
  BCrypt::Password.new(remember_digest).is_password?(remember_token)
 end

 def forget
   update_attribute(:remember_digest, nil) 
 end

 # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

# Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

   def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end