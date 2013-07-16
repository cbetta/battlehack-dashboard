pendingTweets = []

loadTweets = ->
  $.get("/tweets", null, showTweets, "json")

showTweets = (tweets) ->
  for tweet in tweets
    createTweet(tweet) if isNewTweet(tweet)

createTweet = (tweet) ->
  clone = $(".tweet.template").clone()
  clone.attr("id", "tweet_"+tweet.xid)
  clone.removeClass("template")

  clone.children(".text").text(tweet.text)

  $("#tweets").prepend(clone)
  pendingTweets.push clone

isNewTweet = (tweet) ->
  $("tweet_"+tweet.xid).length == 0

showTweet = ->
  element = pendingTweets.shift()
  element.show("slide") if element

$ ->
  loadTweets()
  showTweet()
  setInterval loadTweets, 5000
  setInterval showTweet, 2000