require "rails_helper"

RSpec.describe "api/skills/index.json.jbuilder" do
  context "with 2 skills" do
    before(:each) do
      assign(:skills, [
        create(:skill, name: "Skill 1"),
        create(:skill, name: "Skill 2")
      ])
      render
    end

    it "displays both skills" do

      parsed = JSON.parse(rendered)

      expect(parsed).to be_kind_of(Array)
      expect(parsed.first['name']).to eq('Skill 1')
      expect(parsed.last['name']).to eq('Skill 2')
    end

    it { is_expected.to render_template(:partial => "_skill") }
  end
end
