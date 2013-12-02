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
    @videos = Video.all
    if !@videos.empty?
      @videos.current_user = current_user
    end
  end
end
