# frozen_string_literal: true
class Api::V1::NotificationSettingsController < Api::ApiController
  before_action :validate_token

  def index
    notification_setting = current_user.notification_setting
    render json: { setting: notification_setting }
  end

  def update
    form = Form::NotificationSetting.new(
      current_user.notification_setting,
      params[:setting]&.symbolize_keys
    )

    if form.submit
      render json: { notification_setting: form.object }
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end
end
