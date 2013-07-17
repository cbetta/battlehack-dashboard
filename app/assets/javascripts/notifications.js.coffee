$ ->
  lastNotificationId = null
  visible = false
  shownAt = null
  minified = false
  firstLoad = true

  checkNotifications = ->
    $.get("/notifications/latest", null, showNotifications, "json")

  showNotifications = (notification) ->
    return if notification == null
    if requiresDisplay(notification)
      showNotification(notification)
      minify() if firstLoad
    else if requiresHidding(notification)
      hideNotifications()
    else if requiresMinification(notification)
      minify()

    firstLoad = false

  showNotification = (notification) ->
    visible = true
    shownAt = new Date()
    lastNotificationId = notification.id
    display = $("#notification div")
    display.text(notification.text)
    display.parent().removeClass("minified")
    minified = false
    display.parent().show()
    $("#notification div").fitText(1.5)

  minify = ->
    $("#notification").addClass("minified")
    $("#notification div").fitText(1.5)
    minified = true

  hideNotifications = ->
    visible = false
    lastNotificationId = null
    $("#notification").hide()

  requiresDisplay = (notification) ->
    newNotification = lastNotificationId != notification.id && notification.visible
    notVisible = notification.visible && !visible
    newNotification || notVisible

  requiresMinification = (notification) ->
    new Date() - shownAt > 60000

  requiresHidding = (notification) ->
    !notification.visible && visible


  checkNotifications()
  setInterval checkNotifications, 5000