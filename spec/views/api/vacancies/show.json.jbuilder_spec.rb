require "rails_helper"

RSpec.describe "api/vacancies/show.json.jbuilder" do
  before(:each) do
    assign(:vacancy,
      create(:vacancy, name: "Vacancy 1"),
    )
    render
  end

  it 'displays vacancy' do
    parsed = JSON.parse(rendered)

    expect(parsed).to be_kind_of(Hash)
    expect(parsed['name']).to eq('Vacancy 1')
  end

  it { is_expected.to render_template(partial: "_vacancy_extended") }
end
