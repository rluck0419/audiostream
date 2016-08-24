App.cable.subscriptions.create { channel: "KeyChangeChannel", room: "key_change" },

  connected: ->
    setInterval @change.bind(@), 30000

  received: (data) ->
    setTimeout ( ->
      for l in App.loops
        l
        clearInterval(l)

      App.key = data["key"]
      console.log(App.key)

      for n in data["notes"]
        audioElement = document.createElement('audio')
        audioElement.setAttribute('src', n.upload_url)
        $("body").append(audioElement)

      sounds = document.getElementsByTagName("audio");

      urls = []
      delays = []
      responses = []
      for sound, i in sounds
        offset = 10000;
        if (i % 2 != 0)
          offset += 5000
          if (i > 5)
            offset += 2000

        urls[i] = sound.src
        delays[i] = 3000 * i + offset

        playThing = (i) -> playSample(urls[i], App.convolver)

        responses[i] = ( foo = (i) -> setInterval( playThing.bind(@, i), delays[i] ) )(i)
        App.loops.push(responses[i])
      console.log("key changed", App.loops)
      # `startLoop(sound, delay)`
      $("audio").remove()
    ), 30000

  change: ->
    console.log("changing key")
    @perform("change")
