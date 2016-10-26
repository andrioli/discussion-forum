class Post < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :email
  validates_presence_of :body

  # Using this array constant as a black list of words
  # Ideally it must be implemented as a database table or as a file
  BLACKLIST = [
    'fuck', 'shit', 'bullshit'
  ]

  # Custom getter, consider caching the return value
  def body
    censored_body = self[:body]
    BLACKLIST.each do |word|
      censored_body = censored_body.gsub(
        /( |^)(#{word})( |$)/i, '\1' + '*' * word.length + '\3')
    end unless censored_body.nil?
    return censored_body
  end

  def new_comment(params = {})
    post = Post.new(params)
    post[:mat_path] = "#{self.mat_path}#{self.id}/"
    return post
  end

  def comments
    return Post.where(mat_path: self.new_comment.mat_path).order(updated_at: :desc)
  end
end
