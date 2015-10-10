# == Schema Information
#
# Table name: applicants
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  phone      :text
#  email      :text
#  is_active  :integer          default(1), not null
#  salary     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :applicant do
    name  { "Иванов Иван Отчество#{('а'..'я').to_a.sample}" }
    is_active 1
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

    trait :not_active do
      is_active 0
    end

    trait :low_salary do
      salary 50
    end

  end

end
