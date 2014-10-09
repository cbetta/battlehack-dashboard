$ ->
  previous_statistics = null
  loadStatistics = ->
    $.get("/statistic/latest", null, showStatistics, "json")

  showStatistics = (statistic) ->
    if statistic.html != previous_statistics
      $("#statistics").html(statistic.html)
      previous_statistics = statistic.html

  loadStatistics()
  setInterval loadStatistics, 30000
