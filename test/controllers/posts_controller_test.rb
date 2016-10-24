require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get :index, format: :json
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, format: :json
    end

    assert_response :created
    assert_not_nil assigns(:post)
  end

  test "should show post" do
    get :show, id: @post, format: :json
    assert_response :success
  end
end
