require "rails_helper"

RSpec.describe "_vacancy.json.jbuilder" do
  with :vacancy

  attributes = %w[
    id
		name
    created_at
    available_to
    salary
    phone
    email
  ]

  it "renders a vacancy as json with following attributes: #{attributes.join(', ')}" do
    render partial: "vacancy", locals: {vacancy: vacancy}

    parsed = JSON.parse(rendered)

    expect(parsed).to be_kind_of(Hash)
    expect(parsed.keys.sort).to eq(attributes.sort)

    expect(parsed['id']).to eq(vacancy.id)
    expect(parsed['name']).to eq(vacancy.name)
    expect(parsed['created_at']).to eq(vacancy.created_at.as_json)
    expect(parsed['available_to']).to eq(vacancy.available_to.as_json)
    expect(parsed['salary']).to eq(vacancy.salary)
    expect(parsed['phone']).to eq(vacancy.phone)
    expect(parsed['email']).to eq(vacancy.email)
  end

end