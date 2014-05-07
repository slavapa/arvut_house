require 'rspec'
require 'rspec/expectations'

Given /^a user visits the signin page$/ do
  visit signin_path
end

When /^they submit invalid signin information$/ do
  click_button "Log in"
end

Then /^they should see an error message$/ do
  expect(page).to have_selector('div.alert.alert-error')
end

Given /^the user has an account$/ do
  @user = Person.create(name: "Example User", email: "user@example.com", admin:true,
                      password: "xxxxxx", password_confirmation: "xxxxxx")
end

When /^the user submits valid signin information$/ do
  fill_in "session_email",    with: @user.email
  fill_in "session_password", with: @user.password
  click_button "Log in"
end

Then /^they should see their profile page$/ do
  expect(page).to have_title('List of Events | Haifa Arvut House')
end

Then /^they should see a signout link$/ do
  expect(page).to have_link('Sign out', href: '/en' + signout_path)
end