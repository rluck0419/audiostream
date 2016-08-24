App.cable.subscriptions.create { channel: "KeyChangeChannel", room: "key_change" },

  connected: ->
    setInterval @change.bind(@), 120000

  received: (data) ->
    setTimeout ( ->
      for l in App.loops
        l
        clearInterval(l)

      for n in data["notes"]
        audioElement = document.createElement('audio')
        audioElement.setAttribute('src', n.upload_url)
        $("body").append(audioElement)

      sounds = document.getElementsByTagName("audio");

      urls = []
      delays = []
      for sound, i in sounds
        offset = 5000;
        if (i % 2 != 0)
          offset += 2000
          if (i > 5)
            offset += 2000

        urls[i] = sound.src
        delays[i] = 3000 * i + offset
      fetchResponse0 = setInterval(( ->
          playSample(urls[0], App.convolver)
          ), delays[0])
      fetchResponse1 = setInterval(( ->
          playSample(urls[1], App.convolver)
          ), delays[1])
      fetchResponse2 = setInterval(( ->
          playSample(urls[2], App.convolver)
          ), delays[2])
      fetchResponse3 = setInterval(( ->
        playSample(urls[3], App.convolver)
        ), delays[3])
      fetchResponse4 = setInterval(( ->
        playSample(urls[4], App.convolver)
        ), delays[4])
      fetchResponse5 = setInterval(( ->
        playSample(urls[5], App.convolver)
        ), delays[5])
      fetchResponse6 = setInterval(( ->
        playSample(urls[6], App.convolver)
        ), delays[6])
      fetchResponse7 = setInterval(( ->
        playSample(urls[7], App.convolver)
        ), delays[7])
      fetchResponse8 = setInterval(( ->
        playSample(urls[8], App.convolver)
        ), delays[8])
      fetchResponse9 = setInterval(( ->
        playSample(urls[9], App.convolver)
        ), delays[9])
      App.loops = [
        fetchResponse0,
        fetchResponse1,
        fetchResponse2,
        fetchResponse3,
        fetchResponse4,
        fetchResponse5,
        fetchResponse6,
        fetchResponse7,
        fetchResponse8,
        fetchResponse9,
      ]
      console.log("key changed")
      # `startLoop(sound, delay)`
      $("audio").remove()
    ), 120000

  change: ->
    @perform("change")
