App.cable.subscriptions.create { channel: "KeyChangeChannel", room: "key_change" },

  received: (data) ->
    console.log("received", data)
    $("audio").remove()
    data["notes"]
