class Api::VotesController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery except: [:create, :destroy]

  def create
    v = current_user.votes.where(video_id: params[:id]).first
    if v
      v.destroy
      result = {destroyed: true}
    else
      v = current_user.votes.create(video_id: params[:id])
      result = v
    end
    render json: result.to_json
  end

  def destroy
    v = current_user.votes.where(video_id: params[:id]).first.destroy
    render json: {success: true}
  end

end