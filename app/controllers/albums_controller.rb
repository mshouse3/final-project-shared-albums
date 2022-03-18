class AlbumsController < ApplicationController
  def index
    matching_albums = Album.all

    @list_of_my_albums = matching_albums.order({ :updated_at => :desc })
    @list_of_albums = matching_albums.order({ :updated_at => :desc })

    render({ :template => "albums/index.html.erb" })
  end

  def show
    the_title = params.fetch("album_title")
    the_username = params.fetch("the_username")
    the_owner = User.where({ :username => the_username })

    matching_albums = Album.where({ :owner => the_owner, :title => the_title })

    @the_album = matching_albums.at(0)

    @list_of_photos = @the_album.photos

    render({ :template => "albums/show.html.erb" })
  end

  def create
    the_album = Album.new
    the_album.owner_id = @current_user.id
    the_album.title = params.fetch("query_title")

    if the_album.valid?
      the_album.save
      redirect_to("/users/#{the_album.owner.username}/#{the_album.title}", { :notice => "Album created successfully." })
    else
      redirect_to("/users/#{@current_user.username}", { :alert => the_album.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_album = Album.where({ :id => the_id }).at(0)

    the_album.title = params.fetch("query_title")

    if the_album.valid?
      the_album.save
      redirect_to("/users/#{the_album.owner.username}/#{the_album.title}", { :notice => "Album updated successfully."} )
    else
      redirect_to("/users/#{the_album.owner.username}/#{the_album.title}", { :alert => album.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_album = Album.where({ :id => the_id }).at(0)

    the_album.destroy

    redirect_to("/users/#{@current_user.username}/#{the_album.title}", { :notice => "Album deleted successfully."} )
  end
end
