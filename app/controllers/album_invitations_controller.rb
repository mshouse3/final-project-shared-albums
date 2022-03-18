class AlbumInvitationsController < ApplicationController
  def index
    matching_album_invitations = AlbumInvitation.all

    @list_of_album_invitations = matching_album_invitations.order({ :created_at => :desc })

    render({ :template => "album_invitations/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_album_invitations = AlbumInvitation.where({ :id => the_id })

    @the_album_invitation = matching_album_invitations.at(0)

    render({ :template => "album_invitations/show.html.erb" })
  end

  def create
    the_album_invitation = AlbumInvitation.new
    the_album_invitation.owner_id = @current_user.id
    the_album_invitation.member_id = User.where({ :username => params.fetch("query_member_name") }).first.id
    the_album_invitation.album_id = params.fetch("query_album_id")

    if the_album_invitation.valid?
      the_album_invitation.save
      redirect_to("/users/#{the_album_invitation.owner.username}/albums/#{the_album_invitation.album.title}/edit", { :notice => "Album invitation created successfully." })
    else
      redirect_to("/users/#{the_album_invitation.owner.username}/albums/#{the_album_invitation.album.title}/edit", { :alert => the_album_invitation.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_album_invitation = AlbumInvitation.where({ :id => the_id }).at(0)

    the_album_invitation.owner_id = params.fetch("query_owner_id")
    the_album_invitation.member_id = params.fetch("query_member_id")
    the_album_invitation.album_id = params.fetch("query_album_id")

    if the_album_invitation.valid?
      the_album_invitation.save
      redirect_to("/album_invitations/#{the_album_invitation.id}", { :notice => "Album invitation updated successfully."} )
    else
      redirect_to("/album_invitations/#{the_album_invitation.id}", { :alert => the_album_invitation.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_album_invitation = AlbumInvitation.where({ :id => the_id }).at(0)
    the_album_owner = User.where({ :id => the_album_invitation.owner_id }).first
    the_album_invitation.destroy

    if the_album_owner.id == @current_user.id
      redirect_to("/users/#{@current_user.username}/albums/#{the_album_invitation.album.title}/edit", { :notice => "Album invitation deleted successfully."} )
    else
      redirect_to("/users/#{@current_user.username}", { :notice => "Album invitation deleted successfully."} )
    end
  end

  def add_self
    the_album_invitation = AlbumInvitation.new
    the_album_invitation.owner_id = @current_user.id
    the_album_invitation.member_id = @current_user.id
    the_album_invitation.album_id = params.fetch("album_id")

    if the_album_invitation.valid?
      the_album_invitation.save
      redirect_to("/users/#{the_album_invitation.owner.username}/albums/#{the_album_invitation.album.title}/edit", { :notice => "Album created successfully." })
    else
      redirect_to("/users/#{the_album_invitation.owner.username}/albums/#{the_album_invitation.album.title}/edit", { :alert => the_album_invitation.errors.full_messages.to_sentence })
    end
  end
end
