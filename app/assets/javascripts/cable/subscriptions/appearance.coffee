App.cable.subscriptions.create { channel: "AppearanceChannel", room: "appearance" },

  # Called when the subscription is ready for use on the server.
  connected: ->
    @install()
    @appear()

  # Called when the WebSocket connection is closed.
  disconnected: ->
    @uninstall()

  # Called when the subscription is rejected by the server.
  rejected: ->
    @uninstall()

  received: (data) ->
    console.log("received:" , data)
    $("body").append("<p class='user" + data["user_id"] + "'>" + data["user_email"] + "</p>") if data["type"] == "join"
    class_name = ".user" + data["user_id"]
    console.log(class_name)
    $(class_name).remove() if data["type"] == "leave"

  appear: ->
    # Calls `AppearanceChannel#appear(data)` on the server
    @perform("appear", appearing_on: $("main").data("appearing-on"))

  away: ->
    # Calls `AppearanceChannel#away` on the server.
    @perform("away")

  install: ->
    buttonSelector = "[data-behavior~=appear_away]"

    $(document).on "page:change.appearance", =>
      # @appear()

    $(document).on "click.appearance", buttonSelector, =>
      @away()
      false

    $(buttonSelector).show()

  uninstall: ->
    $(document).off(".appearance")
    $(buttonSelector).hide()
