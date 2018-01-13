class AuthController < ApplicationController

  def facebook
    oauth = Koala::Facebook::OAuth.new
    new_access_info = oauth.exchange_access_token_info(params[:token])

    new_access_token = new_access_info["access_token"]
    new_access_expires_at = DateTime.now + new_access_info["expires_in"].to_i.seconds

    graph = Koala::Facebook::API.new(new_access_token)
    profile = graph.get_object('me', fields: 'id, name, email')

    user = User.where(email: profile["email"], uid: profile["id"]).first_or_initialize.tap do |user|
      user.email = profile["email"]
      user.uid = profile["id"]
      user.name = profile["name"]
      user.token = new_access_token
      user.expires_at = new_access_expires_at
      user.password = SecureRandom.urlsafe_base64 unless user.password != nil
      user.save!
    end
    render json: user
  end
end
