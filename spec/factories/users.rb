FactoryGirl.define do
  factory :test_user, class: User do
    name     'Jane Doe'
    email    'jane@example.com'
    password "123456"
    password_confirmation "123456"

    # factory :test_user do

    # end
  end

    # factory :user, class: User do
    # name     'Jane Doe'
    # email    'jane@example.com'
    # password "123456"
    # password_confirmation "123456"

    # factory :test_user do

    # # end

    # FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"


    # factory :admin do
    #   admin true
    # end
  end
# end

factory :admin, class: User do
    name     'admin'
    email    'admin@example.com'
    password "123456"
    password_confirmation "123456"
    admin 'true'
	end
end
