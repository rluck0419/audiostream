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
    class_name = ".user" + data["user_id"]
    $("audio").remove();

    if data["type"] == "join"
      if not $(class_name).length
        $(".users").append("<div class='user" + data["user_id"] + "'>" + data["user_email"] + "</div>")

      for n in data["notes"]
        audioElement = document.createElement('audio')
        audioElement.setAttribute('src', n.upload_url)
        $("body").append(audioElement)

      console.log("length of sounds", App.sounds.length)
      if App.sounds.length < 1
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

        App.soundObjs[i].url = sound.src
        App.soundObjs[i].delay = 3000 * i + offset

        playThing = (i, yCoord) -> makeNote(App.soundObjs[i], App.convolver, yCoord)

        responses[i] = ( foo = (i) -> setInterval( playThing.bind(@, i, yCoord(i)), App.soundObjs[i].delay ) )(i)
        App.loops.push(responses[i])
      console.log(App.loops)

    $(class_name).remove() if data["type"] == "leave"

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
