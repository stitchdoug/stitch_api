FactoryGirl.define do
  factory :user do
    sequence(:name)     { |n| "Person #{n}" }
    sequence(:username) { |n| "person_#{n}" }
    sequence(:email)    { |n| "person_#{n}@example.com" }
    password  "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :stitch do
    name "Stitch"
    description "Lorem ipsum"
    notes "Stitch notes"
    file_url "http://example.com/stitch_1"
    rejected false
    user
  end
end