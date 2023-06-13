class ApplicationController < ActionController::API
  SECRET_KEY = ENV.fetch("DEVISE_JWT_SECRET_KEY")

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from JWT::DecodeError, with: :unauthorized_error
  rescue_from ActiveRecord::RecordInvalid, with: :error_occurred
  rescue_from ActionController::RoutingError, with: :error_occurred
  rescue_from NameError, with: :error_occurred

  def authenticate_request
    if request.headers["Authorization"].present?
      token = request.headers["Authorization"].split(" ").last
      decoded = JWT.decode(token, SECRET_KEY).first
      current_user = User.find(decoded["sub"])
      response_failure(401, "Unauthorized.") unless current_user.present?
    else
      response_failure(401, "Token missing.")
    end
  end

  def response_success(status, message, data = [])
    render json: { message: message, data: data }, status: status
  end

  def response_failure(status, message = nil, exception = nil)
    render json: { error: message.present? ? message : exception, description: exception }, status: status
  end

  def unauthorized_error(exception)
    render json: { error: "You are unauthorized.", message: "You are unauthorized." }, status: 401
  end

  def record_not_found(exception)
    render json: { error: exception.message, message: "Resource not found." }, status: 404
  end

  def raise_not_found
    render json: { error: "No route matches", messages: "Something went wrong." }, status: 404
  end

  def error_occurred(exception)
    render json: { error: exception.message, message: "Something went wrong." }, status: 500
  end
end
