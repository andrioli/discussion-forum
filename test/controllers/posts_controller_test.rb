require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get :index, format: :json
    assert_response :success
    assert_not_nil assigns(:posts)
    assert_not_empty assigns(:posts)
    assert_equal 1, assigns(:total_pages)
    assert_equal 1, assigns(:page)
  end

  test "should get index in second page" do
    get :index, format: :json, page: 2
    assert_response :success
    assert_not_nil assigns(:posts)
    assert_not_empty assigns(:posts)
    assert_equal 1, assigns(:total_pages)
    assert_equal 1, assigns(:page)
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

  test "post not found" do
    get :show, id: rand(100), format: :json
    assert_response :not_found
  end
end
