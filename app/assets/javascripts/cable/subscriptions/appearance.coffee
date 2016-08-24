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
    if data["type"] == "join"
      if not $(class_name).length
        $(".users").append("<div class='user" + data["user_id"] + "'>" + data["user_email"] + "</div>")

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
      console.log(App.loops)

      $("audio").remove()
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
