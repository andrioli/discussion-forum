json.extract! post, :id, :title, :email, :body, :created_at

# WARN: It does not scale. This n + 1 query problem
json.comments do
  json.array! post.comments, partial: 'posts/post', as: :post
end

json._links do
  json.self post_url post
end
