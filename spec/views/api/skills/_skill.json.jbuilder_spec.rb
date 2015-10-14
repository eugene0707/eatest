require "rails_helper"

RSpec.describe "_skill.json.jbuilder" do
  with :skill

  attributes = %w[
    id
		name
  ]

  it "renders a skill as json with following attributes: #{attributes.join(', ')}" do
    render :partial => "skill", :locals => {:skill => skill}

    parsed = JSON.parse(rendered)

    expect(parsed).to be_kind_of(Hash)
    expect(parsed.keys.sort).to eq attributes.sort

    expect(parsed['id']).to eq skill.id
    expect(parsed['name']).to eq skill.name
  end

end