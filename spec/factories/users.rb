FactoryBot.define do
  factory :user do
    name { 'John' }
    email { "john@email_provider.com" }
    password { "7860945310" }
    id { 1 }
  end

  factory :comment do
    content { "This is a comment." }
    association :user, factory: :user
  end

  factory :post do 
    association :user, factory: :user
    association :comment, factory: :comment
    title { "Random title" }
    body { "Random body" }
    id { 5 }
    
  end
end 