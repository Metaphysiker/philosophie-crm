require 'rails_helper'

RSpec.describe "tasks", :type => :feature do

  before :each do
    user = User.create!(:username => Faker::Internet.username, :email => Faker::Internet.email, :password => "secret")
    visit "/users/sign_in"
    fill_in "Login", :with => user.username
    fill_in "Password", :with => "secret"
    click_button "Log in"

    expect(page).to have_selector(".navbar-brand", :text => user.username)
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
    click_button "Create Task"
    expect(page).to have_content(fake_text)
  end
end
