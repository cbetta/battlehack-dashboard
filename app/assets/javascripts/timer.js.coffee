$ ->
  lastStatus = null

  checkTimer = ->
     $.get("/timer/status", null, updateTimer, "json")

  updateTimer = (timer) ->
    if timer.status == "started" && lastStatus != timer.status
      endTime = new Date(timer.ends_at);
      $("#info time.end").countdown({until: endTime, onTick: formatCountdownTime});
    else if timer.status == "cleared"
      stopTimer()
      formatCountdownTime([0,0,0,0,24,0,0])
    else if timer.status == "ended"
      stopTimer()
      formatCountdownTime([0,0,0,0,0,0,0])
    else if timer.status == "paused"
      stopTimer()
      $('#info time.end').text(timer.remaining);

    lastStatus = timer.status

  stopTimer = ->
    $("#info time.end").countdown('destroy');

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

  checkTimer()
  setInterval checkTimer, 1000


