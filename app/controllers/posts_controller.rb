class PostsController < ApplicationController
  def index
    @posts = current_user.posts.order(created_at: :desc)
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path }
      else
        format.html { render :index }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            @post,
            partial: 'post/form',
            locals: { post: @post }
          )
        }
      end
    end
  end

  def like
    current_user.posts.find_by(id: params[:post_id]).increment(:likes_count).save
    redirect_to posts_path
  end

  def repost
    current_user.posts.find_by(id: params[:post_id]).increment(:repost_count).save
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
