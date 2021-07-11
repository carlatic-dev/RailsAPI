user ||= @current_user

json.user do
  json.id user.id.to_s
  json.email user.email
end