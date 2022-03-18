class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })

    render({ :template => "photos/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_photos = Photo.where({ :id => the_id })

    @the_photo = matching_photos.at(0)

    render({ :template => "photos/show.html.erb" })
  end

  def create
    the_photo = Photo.new
    the_photo.caption = params.fetch("query_caption")
    the_photo.image = params.fetch("query_image")
    the_photo.owner_id = @current_user.id
    the_photo.location = params.fetch("query_location")
    the_photo.album_id = params.fetch("query_album_id")
    the_photo.likes_count = 0
    the_photo.comments_count = 0

    if the_photo.valid?
      the_photo.save
      redirect_to("/users/#{the_photo.album.owner.username}/albums/#{the_photo.album.title}", { :notice => "Photo created successfully." })
    else
      redirect_to("/users/#{the_photo.album.owner.username}/albums/#{the_photo.album.title}", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.caption = params.fetch("query_caption")
    the_photo.image = params.fetch("query_image")
    the_photo.location = params.fetch("query_location")

    if the_photo.valid?
      the_photo.save
      redirect_to("/users/#{the_photo.album.owner.username}/albums/#{the_photo.album.title}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/users/#{the_photo.album.owner.username}/albums/#{the_photo.album.title}/photos/#{the_photo.id}", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.destroy

    redirect_to("/users/#{the_photo.album.owner.username}/albums/#{the_photo.album.title}", { :notice => "Photo deleted successfully."} )
  end
end
