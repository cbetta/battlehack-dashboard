class Tweet
  class Fetcher
    attr :tweets, :last_xid

    def run
      determine_last_xid
      search_tweets
      save_tweets
    rescue Twitter:Error => ex
      Rails.logger.error "Could not fetch tweets: #{ex.message}"
    end

    private

    def determine_last_xid
      @last_xid = Tweet.pluck(:xid).map { |id| id.to_i }.max
    end

    def search_tweets
      if @last_xid.nil?
        @tweets = Twitter.search(ENV["TWITTER_TAG"], :include_entities => true)
      else
        @tweets = Twitter.search(ENV["TWITTER_TAG"], :include_entities => true, :since_id => @last_xid)
      end
    end

    def save_tweets
      @tweets.statuses.each {|status| save status }
    end

    def save status
      Tweet.create! do |tweet|
        tweet.xid = status.id.to_s
        tweet.name = status.user.name
        tweet.screen_name = status.user.screen_name
        tweet.text = status.text
        tweet.media_url = status.media[0].try(:media_url)
        tweet.profile_image_url = status.user.profile_image_url.sub('_normal','_bigger')
        tweet.tweeted_at = status.created_at
      end
    end
  end
end