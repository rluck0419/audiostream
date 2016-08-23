App.cable.subscriptions.create { channel: "KeyChangeChannel", room: "key_change" },

  connected: ->
    setInterval @change(), 10000

  received: (data) ->
    console.log("received", data)
    if App.restartSession == false
      App.restartSession = true
      setTimeout ( ->
        console.log("timeout function running")
        $("audio").remove()
        for l in App.loops
          clearInterval(l)
        for n in data["notes"]
          audioElement = document.createElement('audio')
          audioElement.setAttribute('src', n.upload_url)
          $("body").append(audioElement)
        sounds = document.getElementsByTagName("audio");
        soundObjs = [];

        for sound, i in sounds
          offset = 1000;
          if (i % 2 != 0)
            offset += 1300
            if (i > 5)
              offset += 2000

          delay = 3000 * i + offset;
          console.log(delay)
          console.log(sound)
          `startLoop(sound, delay)`
        App.restartSession = false
        ), 10000

  change: ->
    @perform("change")
