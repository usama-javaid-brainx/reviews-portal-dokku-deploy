# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  username             :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Discard::Model
  include DeviseTokenAuth::Concerns::User
  include Statusable

  has_one_attached :avatar
  default_scope -> { kept }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum app_platform: [:android, :ios, :flutter]
  has_many :reviews, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :ck_editor_images, dependent: :destroy
  has_many :requests, dependent: :destroy

  # validation
  validates :username, uniqueness: true, presence: true
  validates :email, format: { with: /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/, multiline: true }, presence: true, uniqueness: true
  validates :phone_number, uniqueness: true, allow_blank: true, on: :update

  # callbacks
  before_save :set_username_to_downcase
  # methods

  # You can override this method to set confirmation for registration
  def confirmed?
    true
  end

  private

  def set_username_to_downcase
    self.username = self.username.gsub(/\s+/, "").downcase
  end

end
