require 'rails_helper'

RSpec.describe "tasks", :type => :feature do

  before :each do
    create_user_and_login
  end

  it "creates a task" do
    person = Person.create(:email => Faker::Internet.email)
    fake_text = Faker::Lorem.paragraph
    visit "/people/#{person.id}"
    click_on "Aufgaben anzeigen"
    click_on "Aufgabe hinzufügen"
    within find('#new_task') do
      fill_in "Description", :with => fake_text
    end
    click_button "Aufgabe erstellen"
    expect(page).to have_content(fake_text)

  end

  it "delets a task" do
    person = Person.create(:email => Faker::Internet.email)
    person.tasks << Task.create(description: Faker::Lorem.paragraph)
    fake_text = Faker::Lorem.paragraph
    visit "/people/#{person.id}"
    click_on "Aufgaben anzeigen"
    #find(".Energy_Blue").click
    within find('#new_task') do
      fill_in "Description", :with => fake_text
    end
    click_button "Aufgabe erstellen"
    expect(page).to have_content(fake_text)

  end
end

def create_user_and_login
  user = User.create!(:username => Faker::Internet.username, :email => Faker::Internet.email, :password => "secret")
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
