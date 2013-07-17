$ ->
  loadStatistics = ->
    $.get("/statistic/latest", null, showStatistics, "json")

  showStatistics = (statistic) ->
    console.log statistic.html
    $("#statistics").html(statistic.html)

  loadStatistics()
  setInterval loadStatistics, 30000
