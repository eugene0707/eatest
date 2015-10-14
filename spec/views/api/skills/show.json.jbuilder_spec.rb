require "rails_helper"

RSpec.describe "api/skills/show.json.jbuilder" do
  before(:each) do
    assign(:skill,
      create(:skill, name: "Skill 1"),
    )
    render
  end

  it 'displays skill' do
    parsed = JSON.parse(rendered)

    expect(parsed).to be_kind_of(Hash)
    expect(parsed['name']).to eq('Skill 1')
  end

  it { is_expected.to render_template(:partial => "_skill") }
end
