require 'rails_helper'

  def setup
   @base_title = "Ruby on Rails Tutorial Sample App"
  end

RSpec.feature "User Sign Up", type: :feature do
	background { visit signup_path }
	let(:submit) { "Create my account" }

	scenario "should have content 'Sign up'" do
		expect(page).to have_text('Sign up')
	end

	scenario "should have the title 'Sign up'" do
		expect(page).to have_title("#{@base_title} | Sign up")
	end

	scenario 'when signup is invalid, user is not created' do
    expect { click_button submit }.not_to change(User, :count)
  end

	scenario 'when signup is valid, user is created' do
    fill_in "Name",         with: "John Doe"
    fill_in "Email",        with: "john@example.com"
    fill_in "Password",     with: "123456"
    fill_in "Confirmation", with: "123456"
    expect { click_button submit }.to change(User, :count).by(1)
  end
end

RSpec.feature "User Profile Page", type: :feature do
	background { visit user_path(user) }
	let(:user) { FactoryGirl.create(:test_user) }

	scenario 'visit profile page' do
  	# expect(page).to have_content(user.name)
  	expect(page).to have_title(user.name)
	end
end
