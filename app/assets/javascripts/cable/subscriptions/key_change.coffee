App.cable.subscriptions.create { channel: "KeyChangeChannel", room: "key_change" },

  connected: ->
    setInterval @change.bind(@), 120000

  received: (data) ->
    console.log("received", data)
    setTimeout ( ->
      console.log("timeout function running")

      $("audio").remove()
      for l in App.loops
        l
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
      ), 120000

  change: ->
    console.log("performing change")
    @perform("change")
