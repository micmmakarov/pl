class Video < ActiveRecord::Base
  belongs_to :user
  belongs_to :setup
  has_many :votes
  cattr_accessor :current_user

  def votes_count
    votes.count
  end

  def voted
    if current_user.present?
      votes.where(:user_id => current_user.id).any?
    end
  end

end
