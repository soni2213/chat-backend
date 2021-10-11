# frozen_string_literal: true

# handle responses
module ResponseHandler
  extend ActiveSupport::Concern

  def render_success(resource: nil, message: '', status: 200, meta: {})
    render json: {
      resource: resource,
      message: message,
      meta: meta
    }, status: status
  end

  def render_failure(errors: nil, message: '', status: 422)
    render json: {
      errors: errors,
      message: message
    }, status: status
  end
end
