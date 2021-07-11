user ||= @user

json.id user.id.to_s
json.first_name user.first_name
json.last_name user.last_name
json.email user.email
json.token user.api_key.token