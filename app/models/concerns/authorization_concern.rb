# frozen_string_literal: true
module AuthorizationConcern
  def create_or_update_authorization(attr)
    if attr
      auth = Authorization.find_by(platform: attr['platform'],
                                   app_name: attr['app_name'],
                                   user_id: attr['user_id']) || Authorization.new
      form = Form::Authorization.new(auth, attr)
      form.submit
      @auth = form.object
    end
  end

  def build_authorizaiton(attributes, user)
    params = attributes.merge(user_id: user.id)
    create_or_update_authorization(params)
  end
end
