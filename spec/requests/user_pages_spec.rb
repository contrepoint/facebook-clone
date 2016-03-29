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

        expect(page).to have_link('Sign Out')
        expect(page).to have_title('John Doe')
        expect(page).to have_selector('div.alert.alert-success', text: 'Welcome')
      # end
  end
end

RSpec.feature "User Profile Page", type: :feature do
	background { visit user_path(user) }
	let(:user) { FactoryGirl.create(:test_user) }

	scenario 'visit profile page' do
  	expect(page).to have_content(user.name)
  	expect(page).to have_title(user.name)
	end
end


RSpec.feature "User Edit Page", type: :feature do
	let(:user) { FactoryGirl.create(:test_user) }
	background {    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
 }
	let(:new_name) { 'new name' }
	let(:new_email) { 'new_email@example.com' }
	background { visit edit_user_path(user) }

	scenario 'visit edit page' do
  	expect(page).to have_content('Update your profile')
  	expect(page).to have_title('Edit user')
  	expect(page).to have_link('change', href: 'http://gravatar.com/emails')
	end

	scenario 'with valid information' do
    fill_in "Name",             with: new_name
    fill_in "Email",            with: new_email
    fill_in "Password",         with: user.password
    fill_in "Confirm Password", with: user.password
    click_button "Save changes"
    expect(page).to have_title(new_name)
    expect(page).to have_selector('div.alert.alert-success')
    expect(page).to have_link('Sign Out', href: signout_path)
    expect(user.reload.name).to  eq new_name
    expect(user.reload.email).to eq new_email
	end

	scenario "with invalid information" do
    click_button "Save changes"
    expect(page).to have_content('error')
  end
end

RSpec.feature "User Index Page", type: :feature do
	let(:user) { FactoryGirl.create(:test_user) }
	before(:all) { 30.times { FactoryGirl.create(:user) } }
  after(:all)  { User.delete_all }

	before do
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit signin_path
      fill_in "Email",    with: user.email
      fill_in "Password", with: user.password
      click_button "Sign In"
      visit users_path
    end

  scenario "index" do
    expect(page).to have_title('All users')
    expect(page).to have_content('All users')
    expect(page).to have_selector('div.pagination')
    User.paginate(page: 1).each do |user|
      expect(page).to have_selector('li', text: user.name)
    end
  end
end