require "rails_helper"

RSpec.describe "api/vacancies/index.json.jbuilder" do
  context "with 2 vacancies" do
    before(:each) do
      assign(:vacancies, [
        create(:vacancy, name: "Vacancy 1"),
        create(:vacancy, name: "Vacancy 2")
      ])
      render
    end

    it "displays both vacancies" do

      parsed = JSON.parse(rendered)

      expect(parsed).to be_kind_of(Array)
      expect(parsed.first['name']).to eq('Vacancy 1')
      expect(parsed.last['name']).to eq('Vacancy 2')
    end

    it { is_expected.to render_template(partial: "_vacancy") }
  end
end
