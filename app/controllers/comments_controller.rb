class CommentsController < ApplicationController
  def index
    @the_photo = Photo.where({ :id => params.fetch("photo_id") }).first
    matching_comments = @the_photo.comments

    @list_of_comments = matching_comments.order({ :updated_at => :desc })

    render({ :template => "comments/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_comments = Comment.where({ :id => the_id })

    @the_comment = matching_comments.at(0)

    render({ :template => "comments/show.html.erb" })
  end

  def create
    the_comment = Comment.new
    the_comment.body = params.fetch("query_body")
    the_comment.commenter_id = @current_user.id
    the_comment.photo_id = params.fetch("query_photo_id")

    if the_comment.valid?
      the_comment.save
      redirect_to("/users/#{the_comment.photo.album.owner.username}/albums/#{the_comment.photo.album.title}/photos/#{the_comment.photo.id}/comments", { :notice => "Comment created successfully." })
    else
      redirect_to("/users/#{the_comment.photo.album.owner.username}/albums/#{the_comment.photo.album.title}/photos/#{the_comment.photo.id}/comments", { :alert => comment.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_comment = Comment.where({ :id => the_id }).at(0)

    the_comment.body = params.fetch("query_body")
    the_comment.commenter_id = params.fetch("query_commenter_id")
    the_comment.photo_id = params.fetch("query_photo_id")

    if the_comment.valid?
      the_comment.save
      redirect_to("/comments/#{the_comment.id}", { :notice => "Comment updated successfully."} )
    else
      redirect_to("/comments/#{the_comment.id}", { :alert => comment.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_comment = Comment.where({ :id => the_id }).at(0)
    the_photo = the_comment.photo

    the_comment.destroy

    redirect_to("/users/#{the_photo.album.owner.username}/albums/#{the_photo.album.title}/photos/#{the_photo.id}/comments", { :notice => "Comment deleted successfully."} )
  end
end
