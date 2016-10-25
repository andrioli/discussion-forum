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

  test "title is required" do
    post :create, format: :json, email: @post.email, body: @post.body
    assert_response :unprocessable_entity
  end

  test "email is required" do
    post :create, format: :json, title: @post.title, body: @post.body
    assert_response :unprocessable_entity
  end

  test "body is required" do
    post :create, format: :json, title: @post.title, email: @post.email
    assert_response :unprocessable_entity
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, format: :json, title: @post.title, email: @post.email, body: @post.body
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

  test "reply title is required" do
    post :reply, format: :json, id: @post.id, email: @post.email, body: @post.body
    assert_response :unprocessable_entity
  end

  test "reply email is required" do
    post :create, format: :json, id: @post.id, title: @post.title, body: @post.body
    assert_response :unprocessable_entity
  end

  test "reply body is required" do
    post :create, format: :json, id: @post.id, title: @post.title, email: @post.email
    assert_response :unprocessable_entity
  end

  test "should create post reply" do
    assert_difference('Post.count') do
      post :reply, format: :json, id: @post.id, title: @post.title, email: @post.email, body: @post.body
    end

    assert_response :created
    assert_not_nil assigns(:post)
  end

  test "post reply not found" do
    post :reply, format: :json, id: rand(100), title: @post.title, email: @post.email, body: @post.body
    assert_response :not_found
  end
end
