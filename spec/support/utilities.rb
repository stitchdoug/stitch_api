include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "Username",    with: user.username
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well
  cookies[:remember_token] = user.remember_token
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :be_signed_in do |user|
  match do |page|
    page.should have_selector('title', text: user.name)
    page.should have_link('Profile', href: user_path(user))
    page.should have_link('Sign out', href: signout_path)
  end
end

RSpec::Matchers.define :be_signed_out do
  match do |page|
    page.should have_link('Sign in', href: signin_path)
  end
end