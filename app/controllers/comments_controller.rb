class CommentsController < ApplicationController
  before_action :find_micropost
  before_action :find_comment, only: [:destroy]

  def create
    @comment = @micropost.comments.build(params[:comment].permit(:content))
    @comment.user_id = current_user.id

    if @comment.save
      flash[:green] = "Done!"
    else
      flash[:red] = "Error!"
    end
    redirect_to :back
  end

  def destroy
    @comment.destroy
    redirect_to :back
  end

  private

  def find_micropost
    @micropost = Micropost.find(params[:micropost_id])
  end

  def find_comment
    @comment = @micropost.comments.find(params[:id])
  end
end
