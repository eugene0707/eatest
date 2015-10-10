# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :skill do
    name "MyText"
  end

end
