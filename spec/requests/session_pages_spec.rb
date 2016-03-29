require 'rails_helper'

RSpec.feature "Sign In Pages", type: :feature do
	background { visit login_path }
	let(:user) { FactoryGirl.create(:test_user) }

	scenario 'visit signin page' do
  	expect(page).to have_content('Sign In')
  	expect(page).to have_title('Sign In')
	end

	# scenario 'sign in with invalid info' do
		# click_button 'Log In'
		# expect(page).to have_selector(div.alert.alert-error) # doesn't work
	# end

	scenario 'sign in with valid info' do
    fill_in "Email",    with: user.email.upcase
    fill_in "Password", with: user.password
    click_button "Sign In"

    expect(page).to have_title(user.name)
    expect(page).to have_link('Profile', href: user_path(user))
    expect(page).to have_link('Sign Out', href: logout_path)
    expect(page).not_to have_link('Sign In', href: login_path)

    click_link 'Sign Out'
    expect(page).to have_link('Sign In')

  end
end