# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

NOTES = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']

Instrument.create!(name: "piano")

12.times do |i|
  Note.create!(name: NOTES[i], octave: 2, upload: File.open("#{Rails.root}/public/notes/#{NOTES[i]}2.mp3"), upload_content_type: "audio/mp3", instrument: Instrument.where(name: "piano").take!)
end

Reverb.create!(name: "AirportTerminal", upload: File.open("#{Rails.root}/public/reverbs/AirportTerminal.wav"), upload_content_type: "audio/wav")

Scale.create!(name: "major", degrees: [0,2,4,5,7,9,11])
Scale.create!(name: "minor", degrees: [0,2,3,5,7,8,10])
Scale.create!(name: "penta", degrees: [0,2,5,7,9])

TRIAD_0 = [0,2,4]
TRIAD_1 = [0,2,5]
TRIAD_2 = [0,3,5]

Chord.create!(name: 'triad', intervals: [TRIAD_0[0], TRIAD_0[1], TRIAD_0[2]])

Scale.all.each do |scale|
  12.times do |i|
    if scale.degrees.include?(i)
      ScaleNote.create!(scale: scale, note: Note.where(name: NOTES[i]).take!)
    end
  end
end
