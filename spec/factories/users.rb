FactoryGirl.define do
  factory :test_user, class: User do
    name     'Jane Doe'
    email    'jane@example.com'
    password "123456"
    password_confirmation "123456"

    # factory :test_user do

    # end
  end
end
