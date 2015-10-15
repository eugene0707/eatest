require "rails_helper"

RSpec.describe "_applicant.json.jbuilder" do
  with :applicant

  attributes = %w[
    id
    name
    phone
    email
    is_active
    salary
  ]

  it "renders a applicant as json with following attributes: #{attributes.join(', ')}" do
    render partial: "applicant", locals: {applicant: applicant}

    parsed = JSON.parse(rendered)

    expect(parsed).to be_kind_of(Hash)
    expect(parsed.keys.sort).to eq(attributes.sort)

    expect(parsed['id']).to eq(applicant.id)
    expect(parsed['name']).to eq(applicant.name)
    expect(parsed['phone']).to eq(applicant.phone)
    expect(parsed['email']).to eq(applicant.email)
    expect(parsed['is_active']).to eq(applicant.is_active)
    expect(parsed['salary']).to eq(applicant.salary)
  end

end