App.cable.subscriptions.create { channel: "KeyChangeChannel", room: "key_change" },

  connected: ->
    @change()

  received: (data) ->
    console.log("received", data)
    if App.restartSession == false
      setTimeout ( ->
        console.log("timeout function running")
        $("audio").remove()
        for l in App.loops
          clearInterval(l)
        App.restartSession = true
        ), 30000



  change: ->
    @perform("change", appearing_on: $("main").data("appearing-on"))
