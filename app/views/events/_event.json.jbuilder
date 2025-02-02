json.extract! event, :id, :name, :description, :started_at, :finished_at, :created_at, :updated_at
json.url event_url(event, format: :json)
