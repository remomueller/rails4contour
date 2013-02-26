json.array!(@items) do |item|
  json.extract! item, :name, :description, :user_id, :bought_date
  json.url item_url(item, format: :json)
end