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
//= require es6-promise
//= require fetch
//= require jquery
//= require jquery_ujs
//= require materialize-sprockets
//= require turbolinks
//= require_tree .

try {
    window.AudioContext = window.AudioContext || window.webkitAudioContext;
    window.audioContext = new window.AudioContext;
} catch (e) {
    console.error("No web audio API support.")
}

function shuffle(arr) {
    var n, elem, idx;
    for (idx = arr.length; idx; idx--) {
        n = Math.floor(Math.random() * idx);
        elem = arr[idx - 1];
        arr[idx - 1] = arr[n];
        arr[n] - elem;
    }
}

function fetchSample(path) {
  return fetch(path)
    .then(response => response.arrayBuffer())
    .then(arrayBuffer => App.audioContext.decodeAudioData(arrayBuffer));
}

function playSample(path, destination) {
    fetchSample(path).then(response => {
        let bufferSource = App.audioContext.createBufferSource();
        bufferSource.buffer = response;

        if (navigator.userAgent.search("Firefox") > -1) {
          bufferSource.connect(App.gainNode);
          App.gainNode.connect(destination);
        } else {
          bufferSource.connect(App.gainNode).connect(destination);
        }

        bufferSource.start();
        App.gainNode.gain.value = 0.1;
    });
}

function startVisuals() {
    App.canvas = document.getElementById("visuals");
    if (App.canvas !== null) {
        App.canvas.width = document.body.clientWidth; //document.width is obsolete
        App.canvas.height = document.body.clientHeight - 100; //document.height is obsolete
        App.canvasW = App.canvas.width;
        App.canvasH = App.canvas.height;
        App.stage = new createjs.Stage("visuals");
        App.x = function () { return Math.random() * (App.canvasW - 100) + 100; };
        App.y = function () { return Math.random() * (App.canvasH - 100) + 100; };
        createjs.Ticker.setFPS(30);
        createjs.Ticker.addEventListener("tick", App.stage);
    }
}

function getMousePos(canvas, evt) {
    var rect = canvas.getBoundingClientRect();
    return {
        x: evt.clientX - rect.left,
        y: evt.clientY - rect.top
    };
}

function createCircle(x, y, instrument) {
    // var stage = new createjs.Stage("visuals");
    var circle = new createjs.Shape();
    if (instrument == "harp") {
        circle.graphics.beginFill("#35A7FF").drawCircle(100, 100, 10);
    } else if (instrument == "piano") {
        circle.graphics.beginFill("#F8C537").drawCircle(100, 100, 10);
    } else if (instrument == "viola") {
        circle.graphics.beginFill("#662C91").drawCircle(100, 100, 10);
    } else if (instrument == "marimba") {
        circle.graphics.beginFill("#20FC8F").drawCircle(100, 100, 10);
    } else {
        circle.graphics.beginFill("#6D466B").drawCircle(100, 100, 10);
    }
    circle.alpha = 0;
    circle.regX = 100;
    circle.regY = 100;
    circle.x = x;
    circle.y = y;

    App.stage.addChild(circle);

    createjs.Tween.get(circle)
      .to({ scaleX: 5, scaleY: 5, alpha: 1 }, 100, createjs.Ease.getPowInOut(1))
      .to({ scaleX: 0.1, scaleY: 0.1, alpha: 0 }, 4000, createjs.Ease.getPowInOut(1))
}

function createSoundCircle(x, y, instrument) {
    // var stage = new createjs.Stage("visuals");
    var circle = new createjs.Shape();
    if (instrument == "harp") {
        circle.graphics.beginFill("#35A7FF").drawCircle(100, 100, 10);
    } else if (instrument == "piano") {
        circle.graphics.beginFill("#F8C537").drawCircle(100, 100, 10);
    } else if (instrument == "viola") {
        circle.graphics.beginFill("#662C91").drawCircle(100, 100, 10);
    } else if (instrument == "marimba") {
        circle.graphics.beginFill("#20FC8F").drawCircle(100, 100, 10);
    } else {
        circle.graphics.beginFill(instrument).drawCircle(100, 100, 10);
    }
    circle.alpha = 0;
    circle.regX = 100;
    circle.regY = 100;
    circle.x = x;
    circle.y = y;
    var soundIndex = Math.floor(y * (App.sounds.length - 1) / App.canvasH);
    playSample(App.sounds[soundIndex].src, App.convolver);

    App.stage.addChild(circle);

    createjs.Tween.get(circle)
      .to({ scaleX: 5, scaleY: 5, alpha: 1 }, 100, createjs.Ease.getPowInOut(1))
      .to({ scaleX: 0.1, scaleY: 0.1, alpha: 0 }, 4000, createjs.Ease.getPowInOut(1))
}

function makeNote(sound, destination, y) {
    if (sound.instrument.length > 0) {
      createCircle(App.x(), y, sound.instrument);
    } else {
      createCircle(App.x(), y, sound.className);
    }
    playSample(sound.url, destination);
    console.log(sound);
}

function initialize() {
    App.soundObjs = [];
    App.loops = [];

    App.audioContext = window.audioContext;

    App.gainNode = App.audioContext.createGain();
    App.arrayBuffer = new ArrayBuffer(16);
    App.restartSession = false;
    App.key = $(".key");

    App.sounds = [].slice.call($("audio"));
    var reverb = App.sounds[App.sounds.length - 1].src;

    fetchSample(reverb).then(convolverBuffer => {
        App.convolver = App.audioContext.createConvolver();
        App.convolver.buffer = convolverBuffer;
        App.convolver.connect(App.audioContext.destination);
    });

    if ($(".signin").length > 0) {
    // var delayTimes = [1200, 2525, 3300, 4050, 6210, 5150, 8535, 9590]
        $(".users").html("");
        for (var i = 0; i < App.sounds.length - 2; i++) {
            App.soundObjs[i] = new Object();

            App.soundObjs[i].sound = App.sounds[i];
            App.soundObjs[i].url = App.sounds[i].src;
            App.soundObjs[i].instrument = App.sounds[i].className;
            console.log(App.soundObjs[i].instrument);

            // var offset = 10000;
            // if (i % 2 != 0) {
            //     if (i > 5) {
            //       offset += 5000
            //     }
            //     offset += 2000
            // }
            // App.soundObjs[i].delay = 5000 * i + offset;
            App.soundObjs[i].delay = function () { return (Math.random() * 10000 + Math.random() * 10000 + 10000) };
            console.log(App.soundObjs[i].delay);
        }
        for (var i = 0; i < App.soundObjs.length - 1; i++) {
            ( function (i) {
                var yCoord = function() { return (App.canvasH * i / App.sounds.length - 1); };

                var response = setInterval(function (yCoord) {
                  makeNote(App.soundObjs[i], App.convolver, yCoord());
                }.bind(this, yCoord), App.soundObjs[i].delay());
                App.loops.push(response);
                // console.log("loop pushed in!", response);
            })(i);
        }
        $("#visuals").on("click", function () { createSoundCircle(App.mousePos.x, App.mousePos.y, "piano") });
    }
}

var onReady = function() {
    App.mousePos = { x: 0, y: 0 };
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

    if (App.canvas !== null) {
        App.canvas.addEventListener('mousemove', function(evt) {
            App.mousePos = getMousePos(App.canvas, evt);
        }, false);
    }


    $('.modal-trigger').leanModal();

    $(window).resize(function () {
        App.canvas.width = document.body.clientWidth; //document.width is obsolete
        App.canvas.height = document.body.clientHeight - 100; //document.height is obsolete
        App.canvasW = App.canvas.width;
        App.canvasH = App.canvas.height;
    });

    // touch-based event handler for mobile - not quite working yet ******
    // App.canvas.addEventListener('touchstart', function (evt) {
    //   createSoundCircle(evt.pageX, evt.pageY);
    // }, false);
}

$(document).on("turbolinks:load", onReady);
