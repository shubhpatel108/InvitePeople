class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_name
  # attr_accessible :title, :body

  validates :profile_name, presence: true, 
  					  uniqueness: true,
  					  format: {
  					  	with: /\A[a-zA-Z\-\_]+\Z/,
  					  	message: 'Must be formatted correctly.'
  					  }

  def self.create_token(email)
    token = Base64::encode64(email)
    encrypt_token(token)
  end

  def self.encrypt_token(token)
    encrypted_token = $encryptor.encrypt_and_sign(token)
    sign_token(encrypted_token)
  end

  def self.sign_token(encrypted_token)
    signed_token = $verifier.generate(encrypted_token)
    signed_token
  end

  def self.verify_signature(signed_token)
    verified = $verifier.verify(signed_token)
    decrypt_token(verified)
  end

  def self.decrypt_token(verified)
    decrypted_token = $encryptor.decrypt_and_verify(verified)
    decode_token(decrypted_token)
  end

  def self.decode_token(decrypted_token)
    token = Base64::decode64(decrypted_token)
    token
  end

  def self.verify_email_token(email, token)
    @email = Base64::decode64(email)
    expected_email = verify_signature(token)
    @email == expected_email
  end

end
