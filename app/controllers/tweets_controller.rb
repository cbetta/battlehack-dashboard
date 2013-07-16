class TweetsController < ApplicationController
  def index
    render json: Tweet.all, only: [:xid, :text, :name, :screen_name, :media_url, :profile_image_url, :tweeted_at]
  end
end
