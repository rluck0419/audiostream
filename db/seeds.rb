# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

notes = ['C2', 'C#2', 'D2', 'D#2', 'E2', 'F2', 'F#2', 'G2', 'G#2', 'A2', 'A#2', 'B2']

Instrument.create!(name: "piano")

12.times do |i|
  Note.create!(name: notes[i],  upload: File.open("#{Rails.root}/public/notes/#{notes[i]}.mp3"), upload_content_type: "audio/mp3", instrument: Instrument.first)
end

Reverb.create!(name: "AirportTerminal", upload: File.open("#{Rails.root}/public/reverbs/AirportTerminal.wav"), upload_content_type: "audio/wav")

Scale.create!(name: "major")
Scale.create!(name: "penta")

major = [0,2,4,5,7,9,11]
penta = [0,2,5,7,9]

12.times do |i|
  if major.include?(i)
    ScaleNote.create!(scale: Scale.first, note: Note.where(id: (i+1)).take!)
  end

  if penta.include?(i)
    ScaleNote.create!(scale: Scale.second, note: Note.where(id: (i+1)).take!)
  end
end
