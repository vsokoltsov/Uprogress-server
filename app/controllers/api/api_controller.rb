# frozen_string_literal: true
class Api::ApiController < ApplicationController
  include JsonWebToken
  include SessionConcern
  include UserConcern

  rescue_from Api::Error do |e|
    error_response e, e.status, e.addition
  end

  private

  def error_response(exception, code, addition = false)
    obj = { error: exception.message }

    obj[:description] = addition if addition
    if Rails.env.development?
      obj[:exception] = exception.class.name
      obj[:backtrace] = exception.backtrace
    end
    render json: obj, status: code
  end

end
