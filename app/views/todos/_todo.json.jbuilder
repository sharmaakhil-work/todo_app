json.extract! todo, :id, :title, :description, :completed, :due_date, :priority, :created_at, :updated_at
json.url todo_url(todo, format: :json)
