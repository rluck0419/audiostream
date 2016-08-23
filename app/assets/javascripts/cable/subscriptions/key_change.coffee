App.cable.subscriptions.create { channel: "KeyChangeChannel", room: "key_change" },

  connected: ->
    @change()

  received: (data) ->
    console.log("received", data)
    $("audio").remove()

  change: ->
    @perform("change", appearing_on: $("main").data("appearing-on"))
