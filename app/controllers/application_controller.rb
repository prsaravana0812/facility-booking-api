class ApplicationController < ActionController::API
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::ActiveRecord::RecordInvalid, with: :error_occurred
  rescue_from ::ActionController::RoutingError, with: :error_occurred
  rescue_from ::NameError, with: :error_occurred

  def response_success(status, message, data = [])
    render json: { message: message, data: data }, status: status
  end

  def response_failure(status, message = nil, exception = nil)
    render json: { error: message.present? ? message : exception }, status: status
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
