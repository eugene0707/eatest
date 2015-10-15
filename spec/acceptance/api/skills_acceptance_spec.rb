require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Skills' do
  before do
    @skill_1, @skill2=[ create(:skill), create(:skill) ]
  end

  get '/api/skills' do
    example 'List of skills' do
      do_request

      expect(status).to eq(200)
    end
  end

  get '/api/skills/:id' do
    parameter :id, required: true

    let(:id) { @skill_1.id }

    example 'Show skill' do
      do_request

      expect(status).to eq(200)
    end
  end

  post '/api/skills' do
    parameter :skill, required: true

    let(:skill) { attributes_for(:skill) }

    example 'Create new skill' do
      do_request

      expect(status).to eq(201)
    end
  end

  put '/api/skills/:id' do
    parameter :id, required: true
    parameter :skill, required: true

    let(:id) { @skill_1.id }
    let(:skill) { attributes_for(:skill) }

    example 'Update skill' do
      do_request

      expect(status).to eq(200)
    end
  end

  delete '/api/skills/:id' do
    parameter :id, required: true

    let(:id) { @skill_1.id }

    example 'Destroy skill' do
      do_request

      expect(status).to eq(204)
    end
  end

end
