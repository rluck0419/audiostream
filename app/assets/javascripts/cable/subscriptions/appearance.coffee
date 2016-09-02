App.cable.subscriptions.create { channel: "AppearanceChannel", room: "appearance" },

  # Called when the subscription is ready for use on the server.
  connected: ->
    @install()
    @appear()

  # Called when the WebSocket connection is closed.
  disconnected: ->
    @uninstall()

  # Called when the subscription is rejected by the server.
  rejected: ->
    @uninstall()

  received: (data) ->
    console.log("received:" , data)
    App.class_name = ".user" + data["user_id"]
    console.log("class_name", App.class_name)
    class_name = App.class_name
    $("audio").remove()

    if data["type"] == "leave"
      $(App.class_name).remove()
    if data["type"] == "join"
      console.log("user's email: ", data["user_email"])
      if not $(class_name).length
        $(".users").append("<div class='user user" + data["user_id"] + "'>" + data["user_email"] + "</div>")

      for n in data["notes"]
        audioElement = document.createElement('audio')
        audioElement.setAttribute('src', n.upload_url)
        audioElement.setAttribute('user', data["user_email"])
        audioElement.setAttribute('instrument', n.instrument.name)
        $("body").append(audioElement)

      App.sounds = [].slice.call(document.getElementsByTagName("audio"))

      reverb = App.sounds.pop()
      urls = []
      delays = []
      responses = []
      yCoord = (i) -> (App.canvasH * i / App.sounds.length - 1)

      shuffle(App.sounds) # Shuffles array in-place

      for sound, i in App.sounds
        App.soundObjs[i] = sound
        # offset = 10000;
        # if (i % 2 != 0)
        #   offset += 5000
        #   if (i > 5)
        #     offset += 2000

        console.log(data["notes"][i].instrument.name)
        App.soundObjs[i].instrument = data["notes"][i].instrument.name
        App.soundObjs[i].user = data["user_email"]
        App.soundObjs[i].url = sound.src
        App.soundObjs[i].delay = -> (Math.random() * 10000) + (2000 * i) + (Math.random() * 5000) + 5000

        playThing = (i, yCoord) -> makeNote(App.soundObjs[i], App.convolver, yCoord)

        responses[i] = ( foo = (i) -> setInterval( playThing.bind(@, i, yCoord(i)), App.soundObjs[i].delay() ) )(i)
        App.loops.push(responses[i])
        last = i
      instrument_name = data["user_instruments"][0]["name"]
      if App.user.id == data["user_id"]
        $("#visuals").on("click", -> createSoundCircle(App.mousePos.x, App.mousePos.y, instrument_name))

  appear: ->
    # Calls `AppearanceChannel#appear(data)` on the server
    @perform("appear", appearing_on: $("main").data("appearing-on"))

  away: ->
    # Calls `AppearanceChannel#away` on the server.
    @perform("away")

  install: ->
    # buttonSelector = "[data-behavior~=appear_away]"
    #
    # $(document).on "page:change.appearance", =>
    #   # @appear()
    #
    # $(document).on "click.appearance", buttonSelector, =>
    #   @away()
    #   false

    # $(buttonSelector).show()

  uninstall: ->
    $(document).off(".appearance")
    # $(buttonSelector).hide()
