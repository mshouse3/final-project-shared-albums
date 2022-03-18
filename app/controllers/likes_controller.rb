class LikesController < ApplicationController
  def index
    @the_photo = Photo.where({ :id => params.fetch("photo_id") }).first
    matching_likes = @the_photo.likes

    @list_of_likes = matching_likes.order({ :created_at => :desc })

    render({ :template => "likes/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_likes = Like.where({ :id => the_id })

    @the_like = matching_likes.at(0)

    render({ :template => "likes/show.html.erb" })
  end

  def create
    the_like = Like.new
    the_like.user_id = @current_user.id
    the_like.photo_id = params.fetch("query_photo_id")

    if the_like.valid?
      the_like.save
      redirect_to("/users/#{the_like.photo.album.owner.username}/albums/#{the_like.photo.album.title}/photos/#{the_like.photo.id}/likes", { :notice => "Comment created successfully." })
    else
      redirect_to("/users/#{the_like.photo.album.owner.username}/albums/#{the_like.photo.album.title}/photos/#{the_like.photo.id}/likes", { :alert => like.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_like = Like.where({ :id => the_id }).at(0)

    the_like.user_id = params.fetch("query_user_id")
    the_like.photo_id = params.fetch("query_photo_id")

    if the_like.valid?
      the_like.save
      redirect_to("/likes/#{the_like.id}", { :notice => "You liked this photo."} )
    else
      redirect_to("/likes/#{the_like.id}", { :alert => like.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_like = Like.where({ :id => the_id }).at(0)
    the_photo = the_like.photo

    the_like.destroy

    redirect_to("/users/#{the_photo.album.owner.username}/albums/#{the_photo.album.title}/photos/#{the_photo.id}/likes", { :notice => "Photo unliked."} )
  end
end
