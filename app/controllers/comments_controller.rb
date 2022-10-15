class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to "/items/#{params[:item_id]}"
    else
      @item = @comment.item
      @comments = @item.comments
      @purchases = Purchase.all
      render "items/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:message).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
