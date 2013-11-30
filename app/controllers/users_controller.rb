class UsersController < ApplicationController
  before_filter :authenticate_user!

  def profile
    result = {"access_token"=>"ya29.1.AADtN_W0b06DMZZe1yAGKqIduyho6hPVWvihXLrHM0pboJi7zvmR8e8gGX7n6wKPgWjz", "token_type"=>"Bearer", "expires_in"=>3600, "refresh_token"=>"1/Z-Yy2DJcgQ0a9J5UaoQn1qvsnfMMnBDFi-mE7PJHChM"}
    client = YouTubeIt::OAuth2Client.new(client_access_token: result['access_token'], client_refresh_token: result['refresh_token'], client_id: CLIENT_ID, client_secret: CLIENT_SECRET, dev_key: DEV_KEY, expires_at: result['expires_in'])
    begin
      @videos = client.my_videos
    rescue
      client.refresh_access_token!
      #@videos = client.my_videos
    end
    data = {title: "Meow tet", description: "Desc", category: "People", keywords: ["test"], unlisted: true}
    @upload_info = client.upload_token(data, "http://#{request.host}:#{request.port}/uploaded")
  end
end