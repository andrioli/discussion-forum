require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @post = Post.new
  end

  test "blacklist works" do
    @post.body = 'Fuck you'
    assert_equal('**** you', @post.body)

    @post.body = 'This is bullshit'
    assert_equal('This is ********', @post.body)

    @post.body = 'I dont give a shit'
    assert_equal('I dont give a ****', @post.body)
  end

  test "new comment mat_path" do
    @post.id = '1'
    assert_equal('/1/', @post.new_comment.mat_path)
  end
end
