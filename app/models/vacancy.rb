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

class Vacancy < ActiveRecord::Base
  has_and_belongs_to_many :skills
  has_many :applicants, -> { group(Applicant.column_names).having('COUNT("applicants_skills".*)>0') },
           through: :skills
  has_many :strict_applicants, -> (vacancy) { group(Applicant.column_names).having('COUNT("applicants_skills".*)=?', vacancy.skill_ids.size) },
           through: :skills,
           source: :applicants
  has_many :partial_applicants, -> (vacancy) { group(Applicant.column_names).having('COUNT("applicants_skills".*)<?', vacancy.skill_ids.size) },
           through: :skills,
           source: :applicants

  validates_presence_of :name, :available_to, :salary
  validates_presence_of :phone, unless: :email
  validates_presence_of :email, unless: :phone

  validates :phone, phone: true, allow_nil: true
  validates :email, email: true, allow_nil: true

  scope :available, -> {where(arel_table[:available_to].gteq(Date.today))}
  scope :by_salary_desc, -> {order(salary: :desc)}
  scope :for_applicant, -> (applicant, relation_type=nil) {
    having_clause=['COUNT(applicants_skills.*)>0']
    if relation_type==:strict
      having_clause << 'COUNT(skills_vacancies.*)=COUNT(applicants_skills.*)'
    elsif relation_type==:partial
      having_clause << 'COUNT(skills_vacancies.*)>COUNT(applicants_skills.*)'
    end

    joins(:skills)
    .joins("LEFT OUTER JOIN applicants_skills ON skills_vacancies.skill_id=applicants_skills.skill_id AND applicants_skills.applicant_id=#{applicant.id}")
    .available.by_salary_desc
    .group(column_names)
    .having("#{having_clause.join(' AND ')}")
  }
end
