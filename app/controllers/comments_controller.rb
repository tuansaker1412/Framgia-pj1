class CommentsController < ApplicationController
  before_action :find_micropost
  before_action :find_comment, only: [:destroy]

  def create
    @comment = @micropost.comments.create(params[:comment].permit(:content))
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to :back
    else
      render :new
    end
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
