# frozen_string_literal: true
class Api::ApiController < ApplicationController
  protect_from_forgery with: :null_session
end
