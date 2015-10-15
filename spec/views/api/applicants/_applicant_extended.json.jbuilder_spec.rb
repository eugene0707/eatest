require "rails_helper"

RSpec.describe "_applicant_extended.json.jbuilder" do
  before(:each) do
    @skill_1, @skill_2, @skill_3 = [ create(:skill), create(:skill), create(:skill) ]
    @applicant = create(:applicant, skills: [ @skill_1, @skill_2 ])
    @vacancy_1 = create(:vacancy, skills: [ @skill_1, @skill_2 ])
    @vacancy_2 = create(:vacancy, skills: [ @skill_2, @skill_3 ])
    render partial: "applicant_extended", locals: {applicant: @applicant}
  end

  it "renders a applicant with nested entities" do
    parsed = JSON.parse(rendered)

    expect(parsed).to be_kind_of(Hash)
    expect(parsed['skills']).to be_kind_of(Array)
    expect(parsed['strict_vacancies']).to be_kind_of(Array)
    expect(parsed['partial_vacancies']).to be_kind_of(Array)
  end

  it { is_expected.to render_template(partial: "_vacancy") }
  it { is_expected.to render_template(partial: "_skill") }
  it { is_expected.to render_template(partial: "_applicant") }

end