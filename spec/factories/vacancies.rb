# == Schema Information
#
# Table name: vacancies
#
#  id           :integer          not null, primary key
#  name         :text             not null
#  available_to :date             not null
#  salary       :integer          not null
#  phone        :text
#  email        :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :vacancy do
    sequence(:name)  { |n| "Vacancy #{n}" }
    available_to { 1.days.from_now }
    salary 100
    phone '+7(495)123-4567'
    email 'user@example.com'

    trait :phone_only do
      email nil
    end

    trait :email_only do
      phone nil
    end

    trait :no_contacts do
      phone nil
      email nil
    end

    trait :not_available do
      available_to { 1.days.ago }
    end

    trait :low_salary do
      salary 50
    end

  end

end
