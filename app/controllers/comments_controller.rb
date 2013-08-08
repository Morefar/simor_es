class CommentsController < ApplicationController
  before_filter :find_comment, except:  [:create]

  def edit
    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = Comment.new(params[:comment])
    respond_to do |format|
      if @comment.save
        format.js
        format.html { redirect_to @comment.commentable, notice: 'Comment was successfully created.' }
      else
        format.html { render action: "new" }
        format.js { render action: "new"}
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.js
        format.html { redirect_to @comment.commentable, notice: 'Comment was successfully updated.' }
      else
        format.html { render action: "edit" }
        format.js { render action: "edit"}
      end
    end
  end

  private
  def find_comment
    @comment = Comment.find(params[:id]) if params[:id]
  end

end
