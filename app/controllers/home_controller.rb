class HomeController < ApplicationController
  def my_video_list
  end

  def upload

  end

  def uploaded
    if params[:status] == '200'
      v = current_user.videos.new
      v.youtube_id = params[:id]
      v.save!
    end
  end

  def index
    @videos = Video.all.sample(5)
    if !@videos.empty? && user_signed_in?
      Video.current_user = current_user
    end
  end
end
