class Form::Authorization < Form::Base
  attr_accessor :attrs
  attribute :user_id
  attribute :provider
  attribute :platform
  attribute :platform_version
  attribute :app_name
  attribute :app_version

  def initialize(object, params = nil)
    @object = object
    self.attributes = @attrs = params || @object.attributes
  end

  def submit!
    object.assign_attributes(attributes)
    object.save!
    if attrs['device_token'].present?
      object.device.create!(token: attrs[:device_token])
    end
  end
end
