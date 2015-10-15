require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Applicants' do
  before do
    @skill_1, @skill_2, @skill_3 = [ create(:skill), create(:skill), create(:skill) ]
    create(:vacancy, skills: [ @skill_1, @skill_2 ])
    create(:vacancy, skills: [ @skill_2,  @skill_3])
    @applicant_1, @applicant_2 = [ create(:applicant, skills: [ @skill_1, @skill_2 ]), create(:applicant, skills: [ @skill_1 ]) ]
  end

  get '/api/applicants' do
    example 'List of applicants' do
      do_request

      expect(status).to eq(200)
    end
  end

  get '/api/applicants/:id' do
    parameter :id, required: true

    let(:id) { @applicant_1.id }

    example 'Show applicant' do
      do_request

      expect(status).to eq(200)
    end
  end

  post '/api/applicants' do
    parameter :applicant, required: true

    let(:applicant) { attributes_for(:applicant, skill_ids: [@skill_1.id, @skill_2.id]) }

    example 'Create new applicant' do
      do_request

      expect(status).to eq(201)
    end
  end

  put '/api/applicants/:id' do
    parameter :id, required: true
    parameter :applicant, required: true

    let(:id) { @applicant_1.id }
    let(:applicant) { attributes_for(:applicant, skill_ids: [@skill_1.id, @skill_2.id]) }

    example 'Update applicant' do
      do_request

      expect(status).to eq(200)
    end
  end

  delete '/api/applicants/:id' do
    parameter :id, required: true

    let(:id) { @applicant_1.id }

    example 'Destroy applicant' do
      do_request

      expect(status).to eq(204)
    end
  end

end
