require 'day-10/bot'

FactoryGirl.define do
  factory :bot do
    name 'bot 4'
    initialize_with { new(name) }
  end
end
