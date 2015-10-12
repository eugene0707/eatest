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
  has_and_belongs_to_many :vacancies, -> { Vacancy.available.by_salary_desc }
  has_and_belongs_to_many :applicants, -> { Applicant.active.by_salary }

  validates :name, presence: true, uniqueness: true
end
