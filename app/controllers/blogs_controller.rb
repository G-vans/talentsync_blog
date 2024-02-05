class BlogsController < ApplicationController
  before_action :authenticate
  
    def index
        blogs = Blog.all
        render json: blogs, only: [:id, :title, :content, :author, :created_at]
      end
    
      def create
        blog = Blog.new(blog_params)
        if blog.save
          render json: blog, only: [:id, :title, :content, :author, :created_at], status: :created
        else
          render json: blog.errors, status: :unprocessable_entity
        end
      end
    
      def update
        blog = Blog.find_by(id: params[:id])
        if blog
          blog.update(blog_params)
          render json: blog, status: :ok
        else
          render json: { error: 'Blog not found' }, status: :not_found
        end
      end
    
      def destroy
        blog = Blog.find_by(id: params[:id])
        if blog
          blog.destroy
          head :no_content
        else
          render json: { error: 'Blog not found' }, status: :not_found
        end
      end
    
      private
      def blog_params
        params.require(:blog).permit(:title, :content, :author)
      end
end
