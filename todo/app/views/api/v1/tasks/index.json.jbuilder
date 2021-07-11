json.tasks @tasks, partial: 'task', as: :task
# json.total_count @tasks.respond_to?(:total_entries) ?
# @tasks.total_entries : @tasks.to_a.count