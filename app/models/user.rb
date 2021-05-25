class User < ApplicationRecord
  after_initialize :init
  has_secure_password
  has_many :appointments
  validates_presence_of :name, :email, :password_digest
  def init
    self.doctor ||= false
  end
end
