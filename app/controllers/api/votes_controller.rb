class Api::VotesController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery except: :create

  def create
    v = current_user.votes.create(video_id: params[:id])
    render json: v.to_json
  end

  def destroy

  end

end