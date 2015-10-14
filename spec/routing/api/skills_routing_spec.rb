require 'rails_helper'

RSpec.describe 'routes for Skills API' do
  it { expect(get('/api/skills')).to route_to( controller: 'api/skills', action: 'index' ) }
  it { expect(get('/api/skills/1')).to route_to( controller: 'api/skills', action: 'show', id: '1' ) }
  it { expect(post('/api/skills')).to route_to( controller: 'api/skills', action: 'create' ) }
  it { expect(put('/api/skills/1')).to route_to( controller: 'api/skills', action: 'update', id: '1' ) }
  it { expect(delete('/api/skills/1')).to route_to( controller: 'api/skills', action: 'destroy', id: '1' ) }

  it { expect(get('/api/skills/1/edit')).not_to be_routable }
end