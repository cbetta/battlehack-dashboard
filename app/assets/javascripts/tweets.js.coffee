$ ->
  pendingTweets = []
  firstLoad = true

  loadTweets = ->
    $.get("/tweets", null, showTweets, "json")

  showTweets = (tweets) ->
    for tweet in tweets
      createTweet(tweet) if isNewTweet(tweet)
    showFirstTime() if firstLoad

  createTweet = (tweet) ->
    clone = $(".tweet.template").clone()
    clone.attr("id", "tweet_"+tweet.xid)
    clone.removeClass("template")

    clone.children(".text").html(stylize(tweet.text))
    clone.children(".avatar").attr("src", tweet.profile_image_url)
    clone.children("abbr").attr("title", tweet.tweeted_at)
    clone.children(".name").text(tweet.name)
    clone.children(".screen_name").text("@"+tweet.screen_name)

    $("#tweets").prepend(clone)
    pendingTweets.push clone

  isNewTweet = (tweet) ->
    $("#tweet_"+tweet.xid).length == 0

  showTweet = ->
    element = pendingTweets.shift()
    element.slideDown(updateTimes) if element

  updateTimes = ->
    $("abbr").timeago();

  showFirstTime = ->
    firstLoad = false
    while pendingTweets.length > 0
      showTweet()

  stylize = (text) ->
    text = text.replace(/(@\w+)/i, "<strong>$1</strong>")
    text = text.replace(/(http:\/\/[a-z0-9.\/]+)/i, "<strong>$1</strong>")
    return text.replace(/(#\w+)/i, "<strong>$1</strong>")

  # this is where things start
  loadTweets()
  setInterval loadTweets, 5000
  setInterval showTweet, 5000
  setInterval updateTimes, 5000
