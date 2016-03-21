require 'rails_helper'


RSpec.feature "static page content", :type => :feature do
  scenario "should have the content 'Sample App'" do
    visit '/static_pages/home'
    expect(page).to have_text('Sample App')
  end

  scenario "should have the title 'Home'" do
    visit '/static_pages/home'
    expect(page).to have_title('Ruby on Rails Tutorial Sample App | Home')
  end

  scenario "should have the content 'Help'" do
    visit '/static_pages/help'
    expect(page).to have_text('Help')
  end

  scenario "should have the title 'Help'" do
    visit '/static_pages/help'
    expect(page).to have_title('Ruby on Rails Tutorial Sample App | Help')
  end

  scenario "should have the content 'About Us'" do
  	visit '/static_pages/about'
  	expect(page).to have_text('About Us')
  end

  scenario "should have the title 'About Us'" do
    visit '/static_pages/about'
    expect(page).to have_title("Ruby on Rails Tutorial Sample App | About Us")
  end
end
