require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

	describe 'get root page' do
		it 'returns http success' do
			get :home
			expect(response).to have_http_status(:success)
		end

		it 'renders the index template' do
			get :home
			expect(response).to render_template('home')
		end
	end

	describe 'get help page' do
		it 'renders the index template' do
			get :help
			expect(response).to render_template('help')
		end
	end

	describe 'get about page' do
		it 'renders the index template' do
			get :about
			expect(response).to render_template('about')
		end
	end
end
