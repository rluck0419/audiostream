// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {
    var paused = false;

    var audioSection = $('section#audio');
    $('a.html5').click(function() {

        var audio = $('<audio>', {
             controls : 'controls'
        });

        var url = $(this).attr('href');
        $('<source>').attr('src', url).appendTo(audio);
        audioSection.html(audio);
        return false;
    });

    function startLoop(sound, seconds) {
        setInterval(function () { sound.play() }.bind(this), seconds);
    }


    function initialize() {
        var sounds = document.getElementsByTagName("audio");
        var reverb = sounds[-1];
        var soundObjs = [];
        let audioContext = new AudioContext();

        // var delayTimes = [1200, 2525, 3300, 4050, 6210, 5150, 8535, 9590]
        for (var i = 0; i < sounds.length - 1; i++) {
            soundObjs[i] = new Object();

            soundObjs[i].sound = sounds[i];

            var offset = 1000;
            if (i % 2 != 0) {
                if (i > 5) {
                  offset += 200
                }
                offset += 1300
            }

            soundObjs[i].delay = 1000 * i + offset;
            var delay = soundObjs[i].delay;
            // console.log(soundObjs[i].delay);

            startLoop(soundObjs[i].sound, delay);
        }
    }

    $(document).ready(function() {
        initialize();
    });

    document.getElementById('pauseButton').onclick = function() {
        var sounds = document.getElementsByTagName('audio');
        if (paused == false) {
            for (i = 0; i < sounds.length; i++) {
              sounds[i].pause();
              paused = true;
            }
        } else {
            for (i = 0; i < sounds.length; i++) {
              sounds[i].play();
              paused = false;
            }
        }
    };
});
