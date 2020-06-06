class UsersController < ApplicationController
  def create
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    if @user.save
      payload = {email: @user.email}
      token = JWT.encode(payload, Rails.application.secrets.secret_key_base.to_s)
      render json: {user: @user, jwt: token}
      # Use serializer. Don't send back pass_digest, etc
      puts "Saved"
    else
      render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
      puts "Error"
    end
  end

  def login
    @user = User.find do |u|
      u.email.downcase == params["email"].downcase
    end
    if @user && @user.authenticate(params["password"])
      payload = {email: @user.email}
      token = JWT.encode(payload, Rails.application.secrets.secret_key_base.to_s)
      render json: {user: @user, jwt: token}
      # Use serializer. Don't send back pass_digest, etc
    end
  end

  def authenticateJWT
    if JWT.decode(params["jwt"], Rails.application.secrets.secret_key_base.to_s)
      @user = User.find do |u|
        u.email.downcase == JWT.decode(params["jwt"], Rails.application.secrets.secret_key_base.to_s)[0]["email"].downcase
      end
      render json: {user: @user}
      # Use serializer. Don't send back pass_digest, etc
    else
      render json: {err: "User cannot be authenticated."}
    end
    #  The way the auth works is if there is no user object in the local storage on the client's front end,
    #  the page will load a log in and sign up form. If the user does either one a post request is made to
    # create their account or log in, which generates then returns a token and a user object. These are
    # stored in the users local storage, their main app's state is set to logged in, and they will stay
    # logged in each time unless they delete their local storage or sign out.
    # Potential changes will be turning their email into a jwt token, as emails will be unique, not names.
  end
end
