class PostsController < ApplicationController

  # Maximum number of records per page we want to show
  # For simplicity this was set as a constant
  PER_PAGE = 10

  # GET /posts
  def index
    # Pagination is implemented with `limit` and `offset`
    # I don't wanna use any gem for this job
    @posts = Post.limit(PER_PAGE).offset(offset)
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    if @post.save
      render :show, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # Handle record not found exception
  rescue_from(ActiveRecord::RecordNotFound) do |e|
    render json: { message: 'Not found' }, status: :not_found
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.permit(:title, :email, :body)
    end

    # Utility method to know how many pages are available
    def total_pages
      (Post.count + PER_PAGE - 1) / PER_PAGE # Taking advantage from integer division
    end

    # Utility method for requested page number
    def page
      [[params[:page].to_i, 1].max, total_pages].min
    end

    # Utility method for offset
    def offset
      (page - 1) * PER_PAGE
    end
end
