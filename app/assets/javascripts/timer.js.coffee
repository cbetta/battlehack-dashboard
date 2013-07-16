$ ->
  startTime = null
  endTime = null
  timeZone = null
  started = false

  loadConfig = ->
    endTimer = $("#info time.end")
    startTimer = $("#info time.start")

    endTime = new Date(endTimer.attr("datetime"))
    startTime = new Date(startTimer.attr("datetime"))

  startTimer = ->
    started = true
    $("#info time.end").countdown({until: endTime, onTick: formatCountdownTime});

  stopTimer = ->
    started  = false
    if before()
      $('#info time.end').text("24:00:00")
    else
      $('#info time.end').text("00:00:00")

  formatCountdownTime = (periods) ->
    hours = doubleDigit(periods[4])
    minutes = doubleDigit(periods[5])
    seconds = doubleDigit(periods[6])
    $('#info time.end').text(hours + ':' + minutes + ':' + seconds);

  doubleDigit = (n) ->
    if (n < 10)
      return ("0" + n)
    else
      return n

  checkTimer = ->
    if inRange() && !started
      startTimer()
    else if !inRange() && started
      stopTimer()

  inRange = ->
    !before() && !after()

  before = ->
    new Date() - startTime < 0

  after = ->
    new Date() - endTime > 0



  loadConfig()
  stopTimer()
  checkTimer()
  setInterval checkTimer, 1000


