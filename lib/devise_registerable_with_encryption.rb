# This is a devvise module for managing crypted password.
#
# We don't use the one provided with devise because it makes using our own authentification logic more difficult.
module Devise::Models::RegisterableWithEncryption
  extend ActiveSupport::Concern

  included do
    attr_reader :password, :current_password
    attr_protected :password, :password_confirmation
    attr_accessor :password_confirmation
    before_validation :downcase_keys
    before_validation :strip_whitespace
  end

  # Temporarily override devise password encryption to also add the md5 pass for drupal
  # This will no longer be needed once CAS is done for drupal and CAS is changed to first try using bcrypt
  # md5 pass are extermely unsecure and should be avoided at all costs
  def password=(new_password)
    @password = new_password
    self.encrypted_password = password_digest(@password) if @password.present?
  end

  # Verifies whether an password (ie from sign in) is the user password.
  def valid_password?(password)
    return false if encrypted_password.blank?
    bcrypt   = ::BCrypt::Password.new(self.encrypted_password)
    password = ::BCrypt::Engine.hash_secret("#{password}#{self.class.pepper}", bcrypt.salt)
    Devise.secure_compare(password, self.encrypted_password)
  end

  # Set password and password confirmation to nil
  def clean_up_passwords
    self.password = self.password_confirmation = nil
  end

  # Update record attributes when :current_password matches, otherwise returns
  # error on :current_password. It also automatically rejects :password and
  # :password_confirmation if they are blank.
  def update_with_password(params={})
    current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = if valid_password?(current_password)
      update_attributes(params)
    else
      self.attributes = params
      self.valid?
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      false
    end

    clean_up_passwords
    result
  end

  # Updates record attributes without asking for the current password.
  # Never allows to change the current password
  def update_without_password(params={})
    params.delete(:password)
    params.delete(:password_confirmation)
    params.delete(:current_password)

    result = update_attributes(params)
    clean_up_passwords
    result
  end

  def after_database_authentication
  end

  # A reliable way to expose the salt regardless of the implementation.
  def authenticatable_salt
    self.encrypted_password[0,29] if self.encrypted_password
  end

  protected

  # Downcase case-insensitive keys
  def downcase_keys
    (self.class.case_insensitive_keys || []).each { |k| self[k].try(:downcase!) }
  end

  def strip_whitespace
    (self.class.strip_whitespace_keys || []).each { |k| self[k].try(:strip!) }
  end

  # Digests the password using bcrypt.
  def password_digest(password)
    ::BCrypt::Password.create("#{password}#{self.class.pepper}", :cost => self.class.stretches).to_s
  end

  module ClassMethods
    Devise::Models.config(self, :pepper, :stretches)

    # We assume this method already gets the sanitized values from the
    # DatabaseAuthenticatable strategy. If you are using this method on
    # your own, be sure to sanitize the conditions hash to only include
    # the proper fields.
    def find_for_database_authentication(conditions)
      find_for_authentication(conditions)
    end
  end
end

Devise.add_module(:registerable_with_encryption)
