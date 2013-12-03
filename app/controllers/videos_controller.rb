class VideosController < ApplicationController
  def index
    @videos = Video.all
    if !@videos.empty? && user_signed_in?
      Video.current_user = current_user
    end
  end
end