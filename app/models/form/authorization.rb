class Form::Authorization < Form::Base
  attribute :user_id
  attribute :provider
  attribute :platform
  attribute :platform_version
  attribute :app_name
  attribute :app_version

  def submit!
    @object.assign_attributes(attributes)
    @object.save!
  end
end
