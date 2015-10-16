require 'rails_helper'

RSpec.describe HomeController do

  describe 'GET index' do
    before do
      get :index
    end

    it { expect(response).to render_template(:index) }
    it { is_expected.to respond_with :ok }
    it { is_expected.to respond_with_content_type :html }
  end

end