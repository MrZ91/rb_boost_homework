class User::NewsfeedsController < User::AuthenticateController
  def index
    @newsfeeds = current_user.news.recent.includes(owner: :profile).includes(:trackable)
  end

  def destroy
    @newsfeed = current_user.news.find_by(id: params[:id])
    @newsfeed.destroy
  end
end
