require "rails_helper"

RSpec.describe "_vacancy_extended.json.jbuilder" do
  before(:each) do
    @skill_1, @skill_2 = [ create(:skill), create(:skill) ]
    create(:applicant, skills: [ @skill_1, @skill_2 ])
    create(:applicant, skills: [ @skill_2 ])
    @vacancy = create(:vacancy, skills: [ @skill_1, @skill_2 ])
    render partial: "vacancy_extended", locals: {vacancy: @vacancy}
  end

  it "renders a vacancy with nested entities" do
    parsed = JSON.parse(rendered)

    expect(parsed).to be_kind_of(Hash)
    expect(parsed['skills']).to be_kind_of(Array)
    expect(parsed['strict_applicants']).to be_kind_of(Array)
    expect(parsed['partial_applicants']).to be_kind_of(Array)
  end

  it { is_expected.to render_template(partial: "_vacancy") }
  it { is_expected.to render_template(partial: "_skill") }
  it { is_expected.to render_template(partial: "_applicant") }

end