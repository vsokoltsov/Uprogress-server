class Form::Device < Form::Base
  attr_accessor :authorization ,params
  attribute :token
  attribute :authorization_id

  def initialize(params)
    @authorization = Authorization.find(params[:authorization_id])
    self.attributes = params
  end

  def submit
    return unless valid?
    authorization.device.destroy if authorization.device.present?
    super "#{authorization.id}_device"
  end
end
