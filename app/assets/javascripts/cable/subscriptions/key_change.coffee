App.cable.subscriptions.create { channel: "KeyChangeChannel", room: "key_change" },

  connected: ->
    setInterval @change.bind(@), 120000

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
        audioElement.setAttribute('user', data["user_email"])
        audioElement.setAttribute('instrument', data["instrument"].name)
        $("body").append(audioElement)

      App.sounds = [].slice.call(document.getElementsByTagName("audio"))
      reverb = App.sounds.pop()
      urls = []
      delays = []
      responses = []
      yCoord = (i) -> (App.canvasH * i / App.sounds.length - 1)

      for sound, i in App.sounds
        App.soundObjs[i] = sound
        offset = 10000;
        if (i % 2 != 0)
          offset += 5000
          if (i > 5)
            offset += 2000

        App.soundObjs[i].instrument = data["instrument"]
        App.soundObjs[i].user = data["user_email"]
        App.soundObjs[i].url = sound.src
        App.soundObjs[i].delay = 3000 * i + offset

        playThing = (i, yCoord) -> makeNote(App.soundObjs[i], App.convolver, yCoord)

        responses[i] = ( foo = (i) -> setInterval( playThing.bind(@, i, yCoord(i)), App.soundObjs[i].delay ) )(i)
        App.loops.push(responses[i])
    ), 120000

  change: ->
    console.log("changing key")
    @perform("change")
