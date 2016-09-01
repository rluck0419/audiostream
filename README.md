# SoundHouse [![Code Climate](https://codeclimate.com/github/rluck0419/audiostream/badges/gpa.svg)](https://codeclimate.com/github/rluck0419/audiostream) [![Test Coverage](https://codeclimate.com/github/rluck0419/audiostream/badges/coverage.svg)](https://codeclimate.com/github/rluck0419/audiostream/coverage)

### Procedurally generated ambient music

[Listen & Create Here](http://www.soundhouseapp.com)

SoundHouse is a procedurally-generated system of sound creation. Upon visiting the website, any user may listen in to a unique construct of ambient music. After creating an account, users can collaborate, and specify their favorite sounds, scales, keys, and reverberation spaces. By utilizing these preferences, logged-in users can help shape the ambient music in a social-based system of procedurally-generated sound.

This app is based on the concept of Music Systems, as conceived by Brian Eno. This system originally consisted of several loops of tape, each of various lengths. These loops were each hooked up to their own Reel-to-Reel machine, and each loop created a singular sound. In doing so, the division between performer and audience was nullified.

Instead, the system of loops would gradually morph over time - due to the various lengths of tape, each loop would slowly drift out-of-time from each other's "synchronized" starting point. This has been described as creating a "garden of sound", where the composer has been removed from the performance. Instead, the composer must experience the growth of the system over time, discovering new combinations of each sound in the process of their .

By utilizing this concept and adding collaborative interactivity, the "audience" (users) can take on the roles of both the performer and the audience simultaneously. As users join and leave the session, the system continues to morph, creating a near-infinite number of possible musical combinations. Only collaboration can unlock its potential.

This app was created with the intent of providing user interaction and idle background sounds.

Enjoy.

Dependencies & Technologies Used:

* Ruby (2.3.0)

* Rails (5.0.0)

* Postgresql (0.18)

* WebSockets - Enables live updating without refreshing the page, enabling Action Cable for

* Redis - using Websockets "refreshing," the Redis server allows the user to update their note collection and change keys, based on Action Job scripts

* Amazon S3 - Audio File Storage (sample library)

* Web Audio API - Several of the API's "nodes" are used for processing each sound. These "nodes" primarily contribute to convolution reverb (the simulation of sound in a reverberating space) and basic amplitude adjustment (volume control & mixing).

* EaselJS and TweenJS for Visual Interface and Animations

* Cucumber Testing
