require 'rails_helper'

  def setup
   @base_title = "Ruby on Rails Tutorial Sample App"
  end

RSpec.feature 'static page content', :type => :feature do
	background { visit root_path }

	  scenario "should have the content 'Sample App'" do
	    expect(page).to have_text('Sample App')
	  end

	  scenario "should have the title 'Home'" do
	    expect(page).to have_title("#{@base_title}")
	  end

	  scenario "should not have a custom title" do
	  	expect(page).not_to have_title("#{@base_title} | Home")
	  end
end

RSpec.feature 'help page content', :type => :feature do
	background { visit help_path }

  scenario "should have the content 'Help'" do
    expect(page).to have_text('Help')
  end

  scenario "should have the title 'Help'" do
    expect(page).to have_title("#{@base_title} | Help")
  end
end

RSpec.feature 'about page content', :type => :feature do
	background { visit about_path }

  scenario "should have the content 'About Us'" do
  	expect(page).to have_text('About Us')
  end

  scenario "should have the title 'About Us'" do
    expect(page).to have_title("#{@base_title} | About Us")
  end
 end

RSpec.feature 'contact page content', :type => :feature do
	background { visit contact_path }

  scenario "should have the content 'Contact'" do
  	expect(page).to have_text('Contact')
  end

  scenario "should have the title 'Contact'" do
    expect(page).to have_title("#{@base_title} | Contact")
  end
end
