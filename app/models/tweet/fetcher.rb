class Tweet
  class Fetcher
    attr :tweets, :last_xid

    def run
      determine_last_xid
      search_tweets
      save_tweets
    rescue Twitter::Error => ex
      Rails.logger.error "Could not fetch tweets: #{ex.message}"
    end

    private

    def determine_last_xid
      @last_xid = Tweet.pluck(:xid).map { |id| id.to_i }.max
    end

    def search_tweets
      if @last_xid.nil?
        @tweets = twitter.search(ENV["TWITTER_TAG"], :include_entities => true)
      else
        @tweets = twitter.search(ENV["TWITTER_TAG"], :include_entities => true, :since_id => @last_xid)
      end
    end

    def save_tweets
      @tweets.each {|status| save status }
    end

    def save status
      Tweet.create! do |tweet|
        tweet.xid = status.id.to_s
        tweet.name = status.user.name
        tweet.screen_name = status.user.screen_name
        tweet.text = status.text
        tweet.media_url = status.media[0].try(:media_url).to_s
        tweet.profile_image_url = status.user.profile_image_url.to_s.sub('_normal','_bigger')
        tweet.tweeted_at = status.created_at
      end
    end

    def twitter
      @twitter ||= Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      end
    end
  end
end
