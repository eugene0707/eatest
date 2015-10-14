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

require 'rails_helper'

RSpec.describe Vacancy do
  context 'instance' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:created_at) }
    it { is_expected.to respond_to(:available_to) }
    it { is_expected.to respond_to(:salary) }
    it { is_expected.to respond_to(:phone) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to have_and_belong_to_many(:skills) }
    it { is_expected.to respond_to(:applicants) }
    it { is_expected.to respond_to(:strict_applicants) }
    it { is_expected.to respond_to(:partial_applicants) }
  end

  context 'class' do
    it { expect(Vacancy).to respond_to(:available) }
    it { expect(Vacancy).to respond_to(:by_salary_desc) }
  end

  context 'presence validator' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_db_column(:created_at).with_options(null: false) }
    it { is_expected.to validate_presence_of(:available_to) }
    it { is_expected.to validate_presence_of(:salary) }
  end

  context 'email validator' do
    it { is_expected.to allow_value('user@example.com').for(:email) }
    it { is_expected.to allow_value('user+tag@example.com').for(:email) }
    it { is_expected.to_not allow_value('user.example.com').for(:email) }
  end

  context 'phone validator' do
    it { is_expected.to allow_value('+7(495)123-4567').for(:phone) }
    it { is_expected.to_not allow_value('123-4567').for(:phone) }
  end

  context 'contact validator' do
    it { expect(build(:vacancy, :phone_only)).to be_valid }
    it { expect(build(:vacancy, :email_only)).to be_valid }
    it { expect(build(:vacancy, :no_contacts)).to_not be_valid }
  end

  describe 'available' do
    let!(:available_vacancy) {create(:vacancy)}
    let!(:not_available_vacancy) {create(:vacancy, :not_available)}

    it { expect(Vacancy.available).to eq([available_vacancy]) }
  end

  describe 'by_salary_desc' do
    let!(:low_salary_vacancy) {create(:vacancy, :low_salary)}
    let!(:high_salary_vacancy) {create(:vacancy)}

    it { expect(Vacancy.by_salary_desc).to eq([high_salary_vacancy, low_salary_vacancy]) }
  end

  describe 'skills' do
    let(:skill) {create(:skill)}
    let(:vacancy) {create(:vacancy, skills: [skill])}

    it { expect{vacancy.skills << skill}.to raise_error(ActiveRecord::RecordNotUnique) }
  end

  describe 'relative applicants' do
    let(:skill_1) {create(:skill)}
    let(:skill_2) {create(:skill)}
    let(:skill_3) {create(:skill)}
    let(:skill_4) {create(:skill)}
    let(:skill_5) {create(:skill)}
    let(:vacancy) {create(:vacancy, skills: [skill_1, skill_2])}

    let!(:applicant_1) {create(:applicant, skills: [skill_1])}
    let!(:applicant_2) {create(:applicant, salary: 110, skills: [skill_1, skill_2, skill_4])}
    let!(:applicant_3) {create(:applicant, salary: 90, skills: [skill_2, skill_3, skill_4])}
    let!(:applicant_4) {create(:applicant, skills: [skill_5])}
    let!(:applicant_5) {create(:applicant, salary: 80, skills: [skill_1, skill_2])}
    let!(:applicant_6) {create(:applicant, :not_active, skills: [skill_1, skill_2])}
    let!(:applicant_7) {create(:applicant, :not_active, skills: [skill_2])}

    it { expect(vacancy.strict_applicants).to eq([applicant_5, applicant_2]) }
    it { expect(vacancy.partial_applicants).to eq([applicant_3, applicant_1]) }
    it { expect(vacancy.applicants).to eq([applicant_5, applicant_3, applicant_1, applicant_2]) }
  end
end
