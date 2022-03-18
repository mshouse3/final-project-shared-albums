class FriendRequestsController < ApplicationController
  def index
    matching_friend_requests = FriendRequest.all

    @list_of_friend_requests = matching_friend_requests.order({ :created_at => :desc })

    render({ :template => "friend_requests/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_friend_requests = FriendRequest.where({ :id => the_id })

    @the_friend_request = matching_friend_requests.at(0)

    render({ :template => "friend_requests/show.html.erb" })
  end

  def create
    the_friend_request = FriendRequest.new
    the_friend_request.sender_id = @current_user.id
    the_friend_request.recipient_id = params.fetch("query_recipient_id")
    the_friend_request.status = "Pending"

    new_friend = User.where({ :id => the_friend_request.recipient_id }).at(0)

    if the_friend_request.valid?
      the_friend_request.save
      redirect_to("/users/#{new_friend.username}", { :notice => "Friend request sent." })
    else
      redirect_to("/users/#{new_friend.username}", { :alert => friend_request.errors.full_messages.to_sentence })
    end
  end

  def accept
    the_id = params.fetch("path_id")
    the_friend_request = FriendRequest.where({ :id => the_id }).at(0)

    the_friend_request.sender_id = params.fetch("query_sender_id")
    the_friend_request.recipient_id = @current_user.id
    the_friend_request.status = "Accepted"

    new_friend = User.where({ :id => the_friend_request.sender_id }).first

    if the_friend_request.valid?
      the_friend_request.save
      redirect_to("/users/#{new_friend.username}", { :notice => "Friend request accepted!" } )
    else
      redirect_to("/users/#{new_friend.username}", { :alert => friend_request.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_friend_request = FriendRequest.where({ :id => the_id }).at(0)

    the_friend_request.destroy

    redirect_to("/users/#{@current_user.username}/friends", { :notice => "Friend request deleted successfully."} )
  end
end
