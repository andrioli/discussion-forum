# Metadata
json._meta do
  json.total_pages @total_pages
  json.page @page
end

# Data
json.data do
  json.array! @posts, partial: 'posts/post', as: :post
end

# Links
json._links do
  json.self posts_url :page => @page
  json.first posts_url :page => 1
  if @page > 1
    json.prev posts_url :page => @page - 1
  end
  if @page < @total_pages
    json.next posts_url :page => @page + 1
  end
  json.last posts_url :page => @total_pages
end
