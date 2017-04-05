class Form::Device < Form::Base
  attr_accessor :authorization
  attribute :token
  attribute :authorization_id

  validates :token, :authorization_id, presence: true

  def initialize(params)
    @authorization = Authorization.find_by(id: params[:authorization_id])
    self.attributes = params
  end

  def submit
    return unless valid?
    ::Service::TransactionLock.run_with_message "#{authorization.id}_device" do
        authorization.device.destroy if authorization.device.present?
        Device.create!(self.attributes)
    end
  end
end
