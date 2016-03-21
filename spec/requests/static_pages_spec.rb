require 'rails_helper'

  def setup
   @base_title = "Ruby on Rails Tutorial Sample App"
  end

RSpec.feature "static page content", :type => :feature do
  scenario "should have the content 'Sample App'" do
    visit '/static_pages/home'
    expect(page).to have_text('Sample App')
  end

  scenario "should have the title 'Home'" do
    visit static_pages_home_path
    expect(page).to have_title("#{@base_title} | Home")
  end

  scenario "should have the content 'Help'" do
    visit '/static_pages/help'
    expect(page).to have_text('Help')
  end

  scenario "should have the title 'Help'" do
    visit '/static_pages/help'
    expect(page).to have_title("#{@base_title} | Help")
  end

  scenario "should have the content 'About Us'" do
  	visit '/static_pages/about'
  	expect(page).to have_text('About Us')
  end

  scenario "should have the title 'About Us'" do
    visit '/static_pages/about'
    expect(page).to have_title("#{@base_title} | About Us")
  end

  scenario "should have the content 'Contact'" do
  	visit '/static_pages/contact'
  	expect(page).to have_text('Contact')
  end

  scenario "should have the title 'Contact'" do
    visit '/static_pages/contact'
    expect(page).to have_title("#{@base_title} | Contact")
  end
end
