json.extract! post, :id, :title, :email, :body, :created_at
json._links do
  json.self post_url post
end
