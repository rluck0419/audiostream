Given(/^I have an existing user account$/) do
  User.create!(email: "user@example.com", password: "password")
end

Given(/^I have an existing set of sound-based data$/) do
  instrument = Instrument.create!(name: "piano", category: "orchestral")
  Scale.create!(name: "major", degrees: [0,2,4,5,7,9,11])
  Reverb.create!(name: "AirportTerminal", upload: File.open("#{Rails.root}/public/reverbs/AirportTerminal.wav"), upload_content_type: "audio/wav")
  Note.create!(name: "C", octave: 2, upload: File.open("#{Rails.root}/public/notes/#{instrument.name}/C2.mp3"), upload_content_type: "audio/mp3", instrument: instrument)
  Key.create!(name: "C", transposition: 0)
  Chord.create!(name: 'triad', intervals: [0,2,4])
end

When(/^I visit homepage$/) do
  visit root_path
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in(field, with: value)
end

When(/^I click "([^"]*)"$/) do |link|
  click_link(link)
end

When(/^I press "([^"]*)"$/) do |button|
  click_button(button)
end

Then(/^I should see "([^"]*)"$/) do |content|
  assert page.has_content?(content)
end
