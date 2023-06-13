module Socialize
  class Google
    GOOGLE_API = "https://www.googleapis.com/oauth2/v3/userinfo"

    def self.get_user_info(access_token)
      response = RestClient.get "#{GOOGLE_API}", { params: { access_token: access_token } }
      user_info = JSON.parse(response.body)
      password = Devise.friendly_token[0, 20]

      if user_info.present?
        user_object = {
          "email" => user_info["email"].present? ? user_info["email"] : "null",
          "first_name" => user_info["given_name"].present? ? user_info["given_name"] : "null",
          "last_name" => user_info["family_name"].present? ? user_info["family_name"] : "null",
          "display_name" => user_info["name"].present? ? user_info["name"] : "null",
          "password" => password,
          "password_confirmation" => password,
          "access_token" => access_token
        }

        user_object
      end
    rescue Exception => e
      raise e
    end
  end
end
