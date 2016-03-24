require 'rails_helper'

  def setup
   @base_title = "Ruby on Rails Tutorial Sample App"
  end

RSpec.feature "Users", type: :feature do
	background { visit signup_path }

	scenario "should have content 'Sign up'" do
		expect(page).to have_text('Sign up')
	end

	scenario "should have the title 'Sign up'" do
		expect(page).to have_title("#{@base_title} | Sign up")
	end
end
