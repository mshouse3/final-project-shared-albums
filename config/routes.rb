Rails.application.routes.draw do



  # Routes for the Album invitation resource:

  # CREATE
  post("/insert_album_invitation", { :controller => "album_invitations", :action => "create" })
          
  # READ
  get("/album_invitations", { :controller => "album_invitations", :action => "index" })
  
  get("/album_invitations/:path_id", { :controller => "album_invitations", :action => "show" })
  
  # UPDATE
  
  post("/modify_album_invitation/:path_id", { :controller => "album_invitations", :action => "update" })
  
  # DELETE
  get("/delete_album_invitation/:path_id", { :controller => "album_invitations", :action => "destroy" })

  #------------------------------

  # Routes for the Album resource:

  # CREATE
  post("/insert_album", { :controller => "albums", :action => "create" })
          
  # READ
  get("/albums", { :controller => "albums", :action => "index" })
  
  get("/users/:the_username/:album_title", { :controller => "albums", :action => "show" })
  
  # UPDATE
  
  post("/modify_album/:path_id", { :controller => "albums", :action => "update" })
  
  # DELETE
  get("/delete_album/:path_id", { :controller => "albums", :action => "destroy" })

  #------------------------------

  # Routes for the Comment resource:

  # CREATE
  post("/insert_comment", { :controller => "comments", :action => "create" })
          
  # READ
  get("/comments", { :controller => "comments", :action => "index" })
  
  get("/comments/:path_id", { :controller => "comments", :action => "show" })
  
  # UPDATE
  
  post("/modify_comment/:path_id", { :controller => "comments", :action => "update" })
  
  # DELETE
  get("/delete_comment/:path_id", { :controller => "comments", :action => "destroy" })

  #------------------------------

  # Routes for the Friend request resource:

  # CREATE
  post("/insert_friend_request", { :controller => "friend_requests", :action => "create" })
          
  # READ
  get("/users/:the_username/friends", { :controller => "friend_requests", :action => "list_friends" })
  
  get("/friend_requests/:path_id", { :controller => "friend_requests", :action => "show" })
  
  # UPDATE
  
  post("/accept_friend_request/:path_id", { :controller => "friend_requests", :action => "accept" })
  
  # DELETE
  post("/delete_friend_request/:path_id", { :controller => "friend_requests", :action => "destroy" })

  #------------------------------

  # Routes for the Like resource:

  # CREATE
  post("/insert_like", { :controller => "likes", :action => "create" })
          
  # READ
  get("/likes", { :controller => "likes", :action => "index" })
  
  get("/likes/:path_id", { :controller => "likes", :action => "show" })
  
  # UPDATE
  
  post("/modify_like/:path_id", { :controller => "likes", :action => "update" })
  
  # DELETE
  get("/delete_like/:path_id", { :controller => "likes", :action => "destroy" })

  #------------------------------

  # Routes for the Photo resource:

  # CREATE
  post("/insert_photo", { :controller => "photos", :action => "create" })
          
  # READ
  get("/photos", { :controller => "photos", :action => "index" })
  
  get("/photos/:path_id", { :controller => "photos", :action => "show" })
  
  # UPDATE
  
  post("/modify_photo/:path_id", { :controller => "photos", :action => "update" })
  
  # DELETE
  get("/delete_photo/:path_id", { :controller => "photos", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # Search users
  get("/search_users", { :controller => "user_authentication", :action => "search_people" })
  get("/find_user", { :controller => "user_authentication", :action => "find" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

  # GO TO PROFILE
  get("/users/:the_username", { :controller => "user_authentication", :action => "show" })
  get("/", { :controller => "user_authentication", :action => "go_to_profile" })

end
