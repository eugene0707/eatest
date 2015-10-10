# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Skill < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
