App.cable.subscriptions.create { channel: "KeyChangeChannel", room: "key_change" },

  connected: ->
    setInterval @change(), 5000

  received: (data) ->
    console.log("received", data)
    if App.restartSession == false
      setTimeout ( ->
        console.log("timeout function running")
        $("audio").remove()
        for l in App.loops
          clearInterval(l)
        App.restartSession = true
        ), 5000



  change: ->
    @perform("change")
