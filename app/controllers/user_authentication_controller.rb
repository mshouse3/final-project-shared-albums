class UserAuthenticationController < ApplicationController
  # Uncomment this if you want to force users to sign in before any other actions
  skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie] })

  def sign_in_form
    render({ :template => "user_authentication/sign_in.html.erb" })
  end

  def destroy_cookies
    reset_session

    redirect_to("/user_sign_in", { :notice => "Signed out successfully." })
  end

  def create_cookie
    user = User.where({ :email => params.fetch("query_email") }).first
    
    the_supplied_password = params.fetch("query_password")
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/user_sign_in", { :alert => "Incorrect password." })
      else
        session[:user_id] = user.id
      
        redirect_to("/", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/user_sign_in", { :alert => "No user with that email address." })
    end
  end

  def sign_up_form
    render({ :template => "user_authentication/sign_up.html.erb" })
  end

  def create
    @user = User.new
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.username = params.fetch("query_username")
    @user.sent_follow_requests_count = 0
    @user.received_follow_requests_count = 0
    @user.own_photos_count = 0

    save_status = @user.save

    if save_status == true
      session[:user_id] = @user.id
   
      redirect_to("/", { :notice => "User account created successfully."})
    else
      redirect_to("/user_sign_up", { :alert => @user.errors.full_messages.to_sentence })
    end
  end
    
  def edit_profile_form
    render({ :template => "user_authentication/edit_profile.html.erb" })
  end

  def update
    @user = @current_user
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.username = params.fetch("query_username")
    @user.sent_follow_requests_count = params.fetch("query_sent_follow_requests_count")
    @user.received_follow_requests_count = params.fetch("query_received_follow_requests_count")
    @user.own_photos_count = params.fetch("query_own_photos_count")
    
    if @user.valid?
      @user.save

      redirect_to("/", { :notice => "User account updated successfully."})
    else
      render({ :template => "user_authentication/edit_profile_with_errors.html.erb" , :alert => @user.errors.full_messages.to_sentence })
    end
  end

  def destroy
    @current_user.destroy
    reset_session
    
    redirect_to("/user_sign_in", { :notice => "User account cancelled" })
  end

  def show
    # Get user's profile
    @the_user = User.where({ :username => params.fetch("the_username") }).at(0)
    
    # For own profile
    if @the_user.id == @current_user.id

      # Get albums to display on profile
      @list_of_my_albums = Album.where({ :owner_id => @current_user.id }).order({ :updated_at => :desc })
      @list_of_albums = @current_user.albums.order({ :updated_at => :desc })
      # Get pending requests
      @total_friends = @current_user.sent_follow_requests_count + @current_user.received_follow_requests_count

    
    else # For others' profile
    
      # Get friend status
      @the_friend_request_sent = FriendRequest.where({ :sender_id => @current_user.id, :recipient_id => @the_user.id }).at(0)
      @the_friend_request_received = FriendRequest.where({ :sender_id => @the_user.id, :recipient_id => @current_user.id }).at(0)
      @no_connection = @the_friend_request_sent == nil && @the_friend_request_received == nil
      #@pending_connection = @the_friend_request_sent != nil and @the_friend_request_sent.status == "Pending" or @the_friend_request_received != nil and @the_friend_request_received.status == "Pending"
      @are_friends = @the_friend_request_sent != nil && @the_friend_request_sent.status == "Accepted" || @the_friend_request_received != nil && @the_friend_request_received.status == "Accepted"
      if @are_friends
        if @the_friend_request_received == nil
          @friendship = @the_friend_request_sent
        else
          @friendship = @the_friend_request_received
        end
      end

    end

    render({ :template => "user_authentication/profile.html.erb"})
  end

  def search_people
    render({ :template => "user_authentication/search_users.html.erb"})
  end

  def find
    
    @the_user = User.where({ :username => params.fetch("query_username") }).at(0)

    if @the_user == nil
      redirect_to("/search_users", { :alert => "No users with that username found" })
    else
      redirect_to("/users/#{@the_user.username}")
    end
  end

  def go_to_profile
    redirect_to("/users/#{@current_user.username}")
  end
 
end
