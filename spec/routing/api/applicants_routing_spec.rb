require 'rails_helper'

RSpec.describe 'routes for Applicants API' do
  it { expect(get('/api/applicants')).to route_to( controller: 'api/applicants', action: 'index' ) }
  it { expect(get('/api/applicants/1')).to route_to( controller: 'api/applicants', action: 'show', id: '1' ) }
  it { expect(post('/api/applicants')).to route_to( controller: 'api/applicants', action: 'create' ) }
  it { expect(put('/api/applicants/1')).to route_to( controller: 'api/applicants', action: 'update', id: '1' ) }
  it { expect(delete('/api/applicants/1')).to route_to( controller: 'api/applicants', action: 'destroy', id: '1' ) }

  it { expect(get('/api/applicants/1/edit')).not_to be_routable }
end