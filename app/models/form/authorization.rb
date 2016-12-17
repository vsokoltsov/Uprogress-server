class Form::Authorization < Form::Base
  attribute :user_id
  attribute :provider
  attribute :platform
  attribute :platform_version
  attribute :app_name
  attribute :app_version

  def submit!
    self.object.assign_attributes(attributes)
    self.object.save!
  end
end
