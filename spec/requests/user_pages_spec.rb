require 'rails_helper'

  def setup
   @base_title = "Ruby on Rails Tutorial Sample App"
  end

RSpec.feature "User Sign Up", type: :feature do
	background { visit signup_path }
	scenario "should have content 'Sign up'" do
		expect(page).to have_text('Sign up')
	end

	scenario "should have the title 'Sign up'" do
		expect(page).to have_title("#{@base_title} | Sign up")
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
