json.array!(@events) do |event|
  json.extract! event, :id, :content, :activist_id
  json.activist_name event.activist.name
  json.activist_url user_path(event.activist_id)
  
  - if event.eventable_type == 'Comment'
    json.url todos_url(event.eventable.todo)
    json.refer_content = event.eventable.content
  else
    json.url todos_url(event.eventable_id)
    json.refer_content = event.eventable.title
  end
end
