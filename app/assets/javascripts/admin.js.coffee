$ ->
  $("#time").change ->
    value = $("#time").val()
    console.log(value)
    $("#start_timer").attr("href" , $("#start_timer").attr("href") + "&time=" + value)
