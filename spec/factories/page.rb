FactoryGirl.define do |f|
  factory :page do
    name         "A new page"
    content_type "Page"
    body         "This is a brand new page."

    factory :home_page do
      name "Home"
    end
  end
end
