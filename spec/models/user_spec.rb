require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user){ User.create(name: 'a', email: 'a@a.com') }

  describe 'valid user' do
  	let(:user){ User.new(name: 'a', email: 'a@a.com') }
  	subject{ user }
  	it { is_expected.to respond_to(:name) }
  	it { is_expected.to respond_to(:email) }
  	it { is_expected.to be_valid }
  	# Both work
	  	# it 'should be valid' do
		  # 	expect(user).to be_valid
		  # end
  end

  describe 'user without name' do
  	let(:user){ User.new(email: 'a@a.com') }
  	subject{ user }
  	it { is_expected.not_to be_valid }
  end

  describe 'user without email' do
  	let(:user){ User.new(name: 'a') }
  	subject{ user }
  	it { is_expected.not_to be_valid }
  end

  describe 'name is too long' do
  	let(:user){ User.new(name: 'a'*51, email: 'a@a.com') }
  	subject{ user }
  	it { is_expected.not_to be_valid }
  end

  describe "test emails" do
    it "invalid email formats should not pass" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user.email).to eq(invalid_address)
        expect(user).not_to be_valid
      end
    end

    it "valid email formats should pass" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        user.email = valid_address
        expect(user.email).to eq(valid_address)
        expect(user).to be_valid
      end
    end
  end

  describe "email addresses should be unique" do
  	before(:each){ user }
  	# let(:user_with_same_email){ user.dup} # let is lazy-loading. before isn't.
  		# calling user.dup means you have to already create a user in the system. (with user variable)
		let(:user_with_same_email){ User.create(name: 'a', email: 'A@a.CoM') }
		subject{ user_with_same_email }
    it { is_expected.not_to be_valid }
  end
end
