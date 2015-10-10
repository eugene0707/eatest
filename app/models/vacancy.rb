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

  validates_presence_of :name, :available_to, :salary
  validates_presence_of :phone, unless: :email
  validates_presence_of :email, unless: :phone

  validates :phone, phone: true, allow_nil: true
  validates :email, email: true, allow_nil: true

  scope :available, -> {where('available_to >= ?', Date.today)}
  scope :by_salary_desc, -> {order(salary: :desc)}

end
