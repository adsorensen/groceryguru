json.extract! event, :id, :title, :start_time, :end_time
json.url event_url(event, format: :json)