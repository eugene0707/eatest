json.extract! vacancy, :id, :name, :available_to, :salary, :phone, :email
json.created_at vacancy.created_at.to_date