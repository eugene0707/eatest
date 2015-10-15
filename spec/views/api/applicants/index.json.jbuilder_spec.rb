require "rails_helper"

RSpec.describe "api/applicants/index.json.jbuilder" do
  context "with 2 applicants" do
    before(:each) do
      @applicant_1, @applicant_2 = [ create(:applicant), create(:applicant) ]
      assign(:applicants, [ @applicant_1, @applicant_2 ])
      render
    end

    it "displays both applicants" do

      parsed = JSON.parse(rendered)

      expect(parsed).to be_kind_of(Array)
      expect(parsed.first['name']).to eq(@applicant_1.name)
      expect(parsed.last['name']).to eq(@applicant_2.name)
    end

    it { is_expected.to render_template(partial: "_applicant") }
  end
end
