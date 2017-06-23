class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.sort_feed.paginate(page: params[:page]).per_page 5
    end
  end

  def index
    @microposts = Micropost.sort_feed.paginate(page: params[:page]).per_page 10
  end

  def help
  end

  def about
  end
end
