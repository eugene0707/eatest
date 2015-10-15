require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Vacancies' do
  before do
    @skill_1, @skill_2 = [ create(:skill), create(:skill) ]
    create(:applicant, skills: [ @skill_1, @skill_2 ])
    create(:applicant, skills: [ @skill_2 ])
    @vacancy_1, @vacancy_2 = [ create(:vacancy, skills: [ @skill_1, @skill_2 ]), create(:vacancy, skills: [ @skill_1 ]) ]
  end

  get '/api/vacancies' do
    example 'List of vacancies' do
      do_request

      expect(status).to eq(200)
    end
  end

  get '/api/vacancies/:id' do
    parameter :id, required: true

    let(:id) { @vacancy_1.id }

    example 'Show vacancy' do
      do_request

      expect(status).to eq(200)
    end
  end

  post '/api/vacancies' do
    parameter :vacancy, required: true

    let(:vacancy) { attributes_for(:vacancy, skill_ids: [@skill_1.id, @skill_2.id]) }

    example 'Create new vacancy' do
      do_request

      expect(status).to eq(201)
    end
  end

  put '/api/vacancies/:id' do
    parameter :id, required: true
    parameter :vacancy, required: true

    let(:id) { @vacancy_1.id }
    let(:vacancy) { attributes_for(:vacancy, skill_ids: [@skill_1.id, @skill_2.id]) }

    example 'Update vacancy' do
      do_request

      expect(status).to eq(200)
    end
  end

  delete '/api/vacancies/:id' do
    parameter :id, required: true

    let(:id) { @vacancy_1.id }

    example 'Destroy vacancy' do
      do_request

      expect(status).to eq(204)
    end
  end

end
