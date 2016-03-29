require 'rails_helper'

RSpec.feature "Sign In Pages", type: :feature do
	background { visit signin_path }
	let(:user) { FactoryGirl.create(:test_user) }

	scenario 'visit signin page' do
  	expect(page).to have_content('Sign In')
  	expect(page).to have_title('Sign In')
	end

	scenario 'sign in with invalid info' do
		click_button 'Sign In'
		expect(page).to have_selector('div.alert.alert-danger')
	end

	scenario 'sign in with valid info' do
    fill_in "Email",    with: user.email.upcase
    fill_in "Password", with: user.password
    click_button "Sign In"

    expect(page).to have_title(user.name)
    expect(page).to have_link('Profile', href: user_path(user))
    expect(page).to have_link('Settings', href: edit_user_path(user))
    expect(page).to have_link('Sign Out', href: signout_path)
    expect(page).not_to have_link('Sign In', href: signin_path)

    click_link 'Sign Out'
    expect(page).to have_link('Sign In')

  end
end

RSpec.feature 'Authentication', type: :feature do
	let(:user) { FactoryGirl.create(:test_user) }
  scenario "visiting the edit page" do
    visit edit_user_path(user)
    expect(page).to have_title('Sign In')
  end

  # scenario "submitting to the update action" do
  #   before { patch user_path(user) }
  #   expect(page).to redirect_to(signin_path)
  # end
  # doesn't work - if in scenario, before is not allowed. if out of scenario, page not allowed.
end

RSpec.feature 'authorization', type: :feature do
  describe "as wrong user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
    before {    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In" }

    scenario "submitting a GET request to the Users#edit action" do
      visit edit_user_path(wrong_user)
      expect(page).not_to have_title('Edit user')
      # expect(page).to redirect_to(root_url) # CANNOT ACCESS REDIRECT_to
    end

    # describe "submitting a PATCH request to the Users#update action" do
    #   before { patch user_path(wrong_user) }
    #   specify { expect(response).to redirect_to(root_url) }
    # end
  end

  describe "for non-signed-in users" do
    let(:user) { FactoryGirl.create(:user) }

    describe "when attempting to visit a protected page" do
      before do
        visit edit_user_path(user)
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign In"
      end

      describe "after signing in" do

        it "should render the desired protected page" do
          expect(page).to have_title('Edit user')
        end
      end
    end
   end
end