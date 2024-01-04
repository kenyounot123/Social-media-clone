FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end
  sequence :id do |n|
    n
  end

  factory :user do
    name { 'John' }
    email { generate(:email) }
    password { "7860945310" }
    id { generate(:id) } 
  end

  factory :comment do
    content { "This is a comment." }
    association :user, factory: :user

    factory :post_comment do
      association :commentable, factory: :post
    end

    factory :nested_comment do
      association :commentable, factory: :comment
    end
    
  end

  factory :post do 
    association :user, factory: :user
    title { "Random title" }
    body { "Random body" }
    id { generate(:id) }
    
  end
end 