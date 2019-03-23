# frozen_string_literal: true

100.times do
  Article.create(title: Faker::Restaurant.name, content: Faker::Restaurant.description)
end
