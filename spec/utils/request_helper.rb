# frozen_string_literal: true
module RequestHelper
  def json
    JSON.parse(response_body)
  end

  def get_with_token(auth, path, params = {}, headers = {})
    request.headers[SessionConcern::TOKEN_NAME] = retrieve_access_token(auth)
    get path, params: params, headers: headers
  end

  def post_with_token(auth, path, params = {}, headers = {})
    request.headers[SessionConcern::TOKEN_NAME] = retrieve_access_token(auth)
    post path, params: params, headers: headers
  end

  def delete_with_token(auth, path, params = {}, headers = {})
    request.headers[SessionConcern::TOKEN_NAME] = retrieve_access_token(auth)
    delete path, params: params, headers: headers
  end

  def put_with_token(auth, path, params = {}, headers = {})
    request.headers[SessionConcern::TOKEN_NAME] = retrieve_access_token(auth)
    put path, params: params, headers: headers
  end
end
