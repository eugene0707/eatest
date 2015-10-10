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

require 'rails_helper'

RSpec.describe Applicant, type: :model do
  context 'instance' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:phone) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:is_active) }
    it { is_expected.to respond_to(:salary) }
    it { is_expected.to have_and_belong_to_many(:skills) }
  end

  context 'class' do
    it { expect(Applicant).to respond_to(:active) }
    it { expect(Applicant).to respond_to(:by_salary) }
  end

  context 'presence validator' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:is_active) }
    it { is_expected.to validate_presence_of(:salary) }
  end

  context 'russian name validator' do
    it { is_expected.to allow_value('Иванов Иван Иванович').for(:name) }
    it { is_expected.to_not allow_value('Иванов Иван').for(:name) }
    it { is_expected.to_not allow_value('Ivanov Ivan').for(:name) }
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
    it { expect(build(:applicant, :phone_only)).to be_valid }
    it { expect(build(:applicant, :email_only)).to be_valid }
    it { expect(build(:applicant, :no_contacts)).to_not be_valid }
  end

  context 'is_active validator' do
    it { is_expected.to allow_values(0, 1).for(:is_active) }
    it { is_expected.to_not allow_values(-1, 2).for(:is_active) }
  end

  describe 'active' do
    let!(:active_applicant) {create(:applicant)}
    let!(:not_active_applicant) {create(:applicant, :not_active)}

    it { expect(Applicant.active).to eq([active_applicant]) }
  end

  describe 'by_salary' do
    let!(:high_salary_applicant) {create(:applicant)}
    let!(:low_salary_applicant) {create(:applicant, :low_salary)}

    it { expect(Applicant.by_salary).to eq([low_salary_applicant, high_salary_applicant]) }
  end

  describe 'skills' do
    let(:skill) {create(:skill)}
    let(:applicant) {create(:applicant, skills: [skill])}

    it { expect{applicant.skills << skill}.to raise_error(ActiveRecord::RecordNotUnique) }
  end
end
