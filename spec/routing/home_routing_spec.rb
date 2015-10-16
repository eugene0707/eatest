require 'rails_helper'

RSpec.describe 'routes for Home' do
  it { expect(get('/')).to route_to( controller: 'home', action: 'index' ) }
end