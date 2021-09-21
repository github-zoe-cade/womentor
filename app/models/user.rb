# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_one :profile, dependent: :destroy
  # Consider overriding Devise::RegistrationsController & call Profile.create from their
  after_create :create_profile

  private

  def create_profile
    Profile.create(user_id: id)
  end
end
