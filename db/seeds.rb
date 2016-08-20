# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

NOTES = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']

piano = Instrument.create!(name: "piano")
harp = Instrument.create!(name: "harp")
marimba = Instrument.create!(name: "marimba")
instruments = Instrument.all

12.times do |i|
  if i < 6
    Key.create!(name: NOTES[i], transposition: i)
  else
    Key.create!(name: NOTES[i], transposition: i - 12)
  end
end


instruments.each do |instrument|
  12.times do |i|
    Note.create!(name: NOTES[i], octave: 2, upload: File.open("#{Rails.root}/public/notes/#{instrument.name}/#{NOTES[i]}2.mp3"), upload_content_type: "audio/mp3", instrument: instrument)
  end
  12.times do |i|
    Note.create!(name: NOTES[i], octave: 3, upload: File.open("#{Rails.root}/public/notes/#{instrument.name}/#{NOTES[i]}3.mp3"), upload_content_type: "audio/mp3", instrument: instrument)
  end
  12.times do |i|
    Note.create!(name: NOTES[i], octave: 4, upload: File.open("#{Rails.root}/public/notes/#{instrument.name}/#{NOTES[i]}4.mp3"), upload_content_type: "audio/mp3", instrument: instrument)
  end
end

reverb = Reverb.create!(name: "AirportTerminal", upload: File.open("#{Rails.root}/public/reverbs/AirportTerminal.wav"), upload_content_type: "audio/wav")

scale = Scale.create!(name: "major", degrees: [0,2,4,5,7,9,11])
Scale.create!(name: "minor", degrees: [0,2,3,5,7,8,10])
Scale.create!(name: "penta", degrees: [0,2,5,7,9])

TRIAD_0 = [0,2,4]
TRIAD_1 = [0,2,5]
TRIAD_2 = [0,3,5]

chord = Chord.create!(name: 'triad', intervals: [TRIAD_0[0], TRIAD_0[1], TRIAD_0[2]])
Chord.create!(name: 'triad_6', intervals: [TRIAD_1[0], TRIAD_1[1], TRIAD_1[2]])
Chord.create!(name: 'triad_64', intervals: [TRIAD_2[0], TRIAD_2[1], TRIAD_2[2]])

user = User.create!(email: "user@example.com", password: "password")
UserInstrument.create!(user: user, instrument: piano)
UserScale.create!(user: user, scale: scale)
UserReverb.create!(user: user, reverb: reverb)
UserChord.create!(user: user, chord: chord)

Key.all.each do |key|
  Scale.all.each do |s|
    12.times do |i|
      if scale.degrees.map{ |n| n + key.transposition % 12 }.include?(i)
        ScaleNote.create!(scale: s, note: Note.find_by(name: NOTES[i], instrument: piano), key: key)
        ScaleNote.create!(scale: s, note: Note.find_by(name: NOTES[i], instrument: harp), key: key)
        ScaleNote.create!(scale: s, note: Note.find_by(name: NOTES[i], instrument: marimba), key: key)
      end
    end
  end
end
