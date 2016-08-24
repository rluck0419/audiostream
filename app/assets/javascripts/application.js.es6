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
//= require materialize-sprockets
//= require turbolinks
//= require_tree .

function fetchSample(path) {
  return fetch(path)
    .then(response => response.arrayBuffer())
    .then(arrayBuffer => App.audioContext.decodeAudioData(arrayBuffer));
}

function playSample(path, destination) {
    fetchSample(path).then(response => {
        let bufferSource = App.audioContext.createBufferSource();
        bufferSource.buffer = response;
        bufferSource.connect(App.gainNode).connect(destination);
        bufferSource.start();
        App.gainNode.gain.value = 0.25;
    });
}

function initialize() {
    var sounds = document.getElementsByTagName("audio");
    App.soundObjs = [];
    App.audioContext = new AudioContext();
    App.gainNode = App.audioContext.createGain();
    App.arrayBuffer = new ArrayBuffer(16);
    App.restartSession = false;
    App.key = $(".key");

    // var delayTimes = [1200, 2525, 3300, 4050, 6210, 5150, 8535, 9590]
    for (var i = 0; i < sounds.length - 1; i++) {
        App.soundObjs[i] = new Object();

        App.soundObjs[i].sound = sounds[i];
        App.soundObjs[i].url = sounds[i].src;

        var offset = 5000;
        if (i % 2 != 0) {
            if (i > 5) {
              offset += 2000
            }
            offset += 2000
        }
        App.soundObjs[i].delay = 5000 * i + offset;
        console.log(App.soundObjs[i].delay);

        // startLoop(soundObjs[i].sound, delay);
    }

    var reverb = sounds[sounds.length - 1].src;
    fetchSample(reverb).then(convolverBuffer => {

        App.convolver = App.audioContext.createConvolver();
        App.convolver.buffer = convolverBuffer;
        App.convolver.connect(App.audioContext.destination);
        App.gainNode.connect(App.audioContext.destination);

        var fetchResponse0 = setInterval( function () { playSample(App.soundObjs[0].url, App.convolver) }, App.soundObjs[0].delay);
        var fetchResponse1 = setInterval( function () { playSample(App.soundObjs[1].url, App.convolver) }, App.soundObjs[1].delay);
        var fetchResponse2 = setInterval( function () { playSample(App.soundObjs[2].url, App.convolver) }, App.soundObjs[2].delay);
        var fetchResponse3 = setInterval( function () { playSample(App.soundObjs[3].url, App.convolver) }, App.soundObjs[3].delay);
        var fetchResponse4 = setInterval( function () { playSample(App.soundObjs[4].url, App.convolver) }, App.soundObjs[4].delay);
        var fetchResponse5 = setInterval( function () { playSample(App.soundObjs[5].url, App.convolver) }, App.soundObjs[5].delay);
        var fetchResponse6 = setInterval( function () { playSample(App.soundObjs[6].url, App.convolver) }, App.soundObjs[6].delay);
        var fetchResponse7 = setInterval( function () { playSample(App.soundObjs[7].url, App.convolver) }, App.soundObjs[7].delay);
        var fetchResponse8 = setInterval( function () { playSample(App.soundObjs[8].url, App.convolver) }, App.soundObjs[8].delay);
        var fetchResponse9 = setInterval( function () { playSample(App.soundObjs[9].url, App.convolver) }, App.soundObjs[9].delay);
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
          fetchResponse9
        ];
    });

    $("audio").remove();

    // document.getElementById('pauseButton').onclick = function() {
    //     var sounds = document.getElementsByTagName('audio');
    //     if (paused == false) {
    //         for (i = 0; i < sounds.length; i++) {
    //           sounds[i].pause();
    //           paused = true;
    //         }
    //     } else {
    //         for (i = 0; i < sounds.length; i++) {
    //           sounds[i].play();
    //           paused = false;
    //         }
    //     }
    // }
}

$(document).ready(function() {
    $('select').material_select();
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

    initialize();
});
