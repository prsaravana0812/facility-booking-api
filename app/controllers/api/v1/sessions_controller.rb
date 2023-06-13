class Api::V1::SessionsController < Devise::SessionsController

  def create
    @user = User.find_or_create_user(user_params)
    sign_in(:user, @user)
    respond_with @user
  rescue RestClient::Exception => e
    response_failure(401, "Google token expired.", e)
  end

  private
    def user_params
      params.require(:user).permit(:access_token)
    end

    def respond_with(resource, _opts = {})
      user_data = ActiveModelSerializers::SerializableResource.new(resource, serializer: UserSerializer)
      response_success(200, "You are successfully logged in.", user_data)
    end

    def respond_to_on_destroy
      head :ok
    end

    def resource
      @user ||= User.new
    end
end
