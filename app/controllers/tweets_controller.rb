class TweetsController < ApplicationController
  def index
    render json: Tweet.order("tweeted_at ASC").last(10), only: [:xid, :text, :name, :screen_name, :media_url, :profile_image_url, :tweeted_at]
  end
end
