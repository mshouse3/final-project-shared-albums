class AlbumsController < ApplicationController
  def index
    matching_albums = Album.all

    @list_of_albums = matching_albums.order({ :created_at => :desc })

    render({ :template => "albums/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_albums = Album.where({ :id => the_id })

    @the_album = matching_albums.at(0)

    render({ :template => "albums/show.html.erb" })
  end

  def create
    the_album = Album.new
    the_album.owner_id = params.fetch("query_owner_id")
    the_album.title = params.fetch("query_title")

    if the_album.valid?
      the_album.save
      redirect_to("/albums", { :notice => "Album created successfully." })
    else
      redirect_to("/albums", { :alert => album.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_album = Album.where({ :id => the_id }).at(0)

    the_album.owner_id = params.fetch("query_owner_id")
    the_album.title = params.fetch("query_title")

    if the_album.valid?
      the_album.save
      redirect_to("/albums/#{the_album.id}", { :notice => "Album updated successfully."} )
    else
      redirect_to("/albums/#{the_album.id}", { :alert => album.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_album = Album.where({ :id => the_id }).at(0)

    the_album.destroy

    redirect_to("/albums", { :notice => "Album deleted successfully."} )
  end
end
