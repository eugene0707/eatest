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

class Applicant < ActiveRecord::Base
  has_and_belongs_to_many :skills

  validates_presence_of :name, :is_active, :salary
  validates_presence_of :phone, unless: :email
  validates_presence_of :email, unless: :phone

  validates :name, russian_name: true
  validates :salary, numericality: { only_integer: true, greater_than: 0 }
  validates :phone, phone: true, allow_nil: true
  validates :email, email: true, allow_nil: true
  validates :is_active, inclusion: { in: [0, 1] }

  scope :active, -> {where(is_active: 1)}
  scope :by_salary, -> {order(salary: :asc)}

  def vacancies
    Vacancy.for_applicant(self)
  end

  def strict_vacancies
    Vacancy.for_applicant(self, :strict)
  end

  def partial_vacancies
    Vacancy.for_applicant(self, :partial)
  end
end
