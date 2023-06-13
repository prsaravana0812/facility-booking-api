class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :jwt_authenticatable, :registerable, jwt_revocation_strategy: JwtDenylist

  has_many :events

  def self.find_or_create_user(params)
    User.transaction do
      user_info = Socialize::Google.get_user_info(params["access_token"])
      user = User.find_by(email: user_info["email"])
      user = User.new(user_info) unless user.present?
      user.present? ? user.update!(user_info) : user.save!
      user
    end
  rescue Exception => e
    raise e
  end
end
