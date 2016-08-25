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

      $("audio").remove();
      for n in data["notes"]
        audioElement = document.createElement('audio')
        audioElement.setAttribute('src', n.upload_url)
        $("body").append(audioElement)

      App.sounds = [].slice.call(document.getElementsByTagName("audio"))
      reverb = App.sounds.pop()
      urls = []
      delays = []
      responses = []
      yCoord = (i) -> (App.canvasH * i / App.sounds.length - 1)

      for sound, i in App.sounds
        offset = 10000;
        if (i % 2 != 0)
          offset += 5000
          if (i > 5)
            offset += 2000

        urls[i] = sound.src
        delays[i] = 3000 * i + offset

        playThing = (i, yCoord) -> makeNote(urls[i], App.convolver, yCoord)

        responses[i] = ( foo = (i) -> setInterval( playThing.bind(@, i, yCoord(i)), delays[i] ) )(i)
        App.loops.push(responses[i])
      console.log("key changed", App.loops)
    ), 30000

  change: ->
    console.log("changing key")
    @perform("change")
