require 'rails_helper'

RSpec.describe 'routes for Vacancies API' do
  it { expect(get('/api/vacancies')).to route_to( controller: 'api/vacancies', action: 'index' ) }
  it { expect(get('/api/vacancies/1')).to route_to( controller: 'api/vacancies', action: 'show', id: '1' ) }
  it { expect(post('/api/vacancies')).to route_to( controller: 'api/vacancies', action: 'create' ) }
  it { expect(put('/api/vacancies/1')).to route_to( controller: 'api/vacancies', action: 'update', id: '1' ) }
  it { expect(delete('/api/vacancies/1')).to route_to( controller: 'api/vacancies', action: 'destroy', id: '1' ) }

  it { expect(get('/api/vacancies/1/edit')).not_to be_routable }
end