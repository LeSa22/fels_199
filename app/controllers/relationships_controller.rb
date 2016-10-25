class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find_by id: params[:followed_id]
    check_user user, "follow"
  end

  def destroy
    user = Relationship.find_by(id: params[:id]).followed
    check_user user, "unfollow"
  end

  def check_user user, relationship
    unless user
      flash[:danger] = t "new_user.danger"
      redirect_to root_url
    end
    if relationship == "follow"
      follow user
    else
      unfollow user
    end
    respond_to do |format|
      format.html  {redirect_to user}
    end
  end

  def follow user
    current_user.follow user
  end

  def unfollow user
    current_user.unfollow user
  end
end
