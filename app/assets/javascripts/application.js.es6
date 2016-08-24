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
  console.log(path)
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
        App.gainNode.gain.value = 0.2;
    });
}

function initialize() {
    var sounds = document.getElementsByTagName("audio");
    App.soundObjs = [];
    App.loops = [];
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

        var offset = 10000;
        if (i % 2 != 0) {
            if (i > 5) {
              offset += 5000
            }
            offset += 2000
        }
        App.soundObjs[i].delay = 5000 * i + offset;
        console.log(App.soundObjs[i].delay);
    }

    var reverb = sounds[sounds.length - 1].src;
    fetchSample(reverb).then(convolverBuffer => {

        App.convolver = App.audioContext.createConvolver();
        App.convolver.buffer = convolverBuffer;
        App.convolver.connect(App.audioContext.destination);

        // for (var i = 0; i < App.soundObjs.length - 1; i++) {
        //     ( function (i) {
        //         var response = setInterval( function () { playSample(App.soundObjs[i].url, App.convolver) }, App.soundObjs[i].delay);
        //         App.loops.push(response);
        //     })(i);
        // }
    });
    // console.log(App.loops);
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

function startVisuals() {
    var canvas = document.getElementById("visuals");
    canvas.width = document.body.clientWidth; //document.width is obsolete
    canvas.height = document.body.clientHeight; //document.height is obsolete
    var canvasW = canvas.width;
    var canvasH = canvas.height;
    createCircle();
}

function createCircle() {
    var stage = new createjs.Stage("visuals");
    var circle = new createjs.Shape();
    circle.graphics.beginFill("DeepSkyBlue").drawCircle(100, 100, 10);
    circle.alpha = 0;
    circle.regX = 100;
    circle.regY = 100;
    circle.x = 200;
    circle.y = 200;
    stage.addChild(circle);


    // createjs.Tween.get(circle, {override:true}).to({ alpha: 1 }).addEventListener("change", handleChange);
    // function handleChange(event) {
    //     // The tween changed.
    //     console.log("event happend", event)
        console.log(circle)
    // }

    createjs.Tween.get(circle)
      .to({ scaleX: 4, scaleY: 4, alpha: 1 }, 2000, createjs.Ease.getPowInOut(1))
      .to({ scaleX: 1, scaleY: 1, alpha: 0 }, 1000, createjs.Ease.getPowInOut(1))

    createjs.Ticker.setFPS(30);
    createjs.Ticker.addEventListener("tick", stage);
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

    startVisuals();
    initialize();
});
