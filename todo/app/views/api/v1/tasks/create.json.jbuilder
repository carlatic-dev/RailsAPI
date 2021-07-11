task ||= @task

json.id task.id.to_s
json.title task.title
json.completed task.completed
json.user_id task.user_id.to_s