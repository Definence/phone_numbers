def login_user(user)
  token = user&.auth_token
  request.headers['auth-token'] = token
end
