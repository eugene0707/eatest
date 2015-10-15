require "rails_helper"

RSpec.describe "api/applicants/show.json.jbuilder" do
  before(:each) do
    @applicant_1 = create(:applicant)
    assign(:applicant, @applicant_1)
    render
  end

  it 'displays applicant' do
    parsed = JSON.parse(rendered)

    expect(parsed).to be_kind_of(Hash)
    expect(parsed['name']).to eq(@applicant_1.name)
  end

  it { is_expected.to render_template(partial: "_applicant_extended") }
end
