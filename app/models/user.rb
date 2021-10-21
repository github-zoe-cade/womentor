# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include GraphqlDevise::Concerns::Model

  has_one :profile, dependent: :destroy

  # Consider overriding Devise::RegistrationsController & call Profile.create from there
  after_create :create_user_records

  private

  def create_user_records
    Profile.create_records(self)
  end
end
