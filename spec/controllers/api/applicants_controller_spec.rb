require 'rails_helper'

RSpec.describe Api::ApplicantsController do

  it { is_expected.to rescue_from(ActiveRecord::RecordNotFound) }
  it { is_expected.to rescue_from(ActiveRecord::RecordNotUnique) }
  it { is_expected.to rescue_from(ActionController::ParameterMissing) }

  describe 'GET index' do
    before do
      @applicant_1, @applicant_2  = [ create(:applicant), create(:applicant) ]
      get :index
    end

    it { expect(assigns(:applicants)).to eq([@applicant_1, @applicant_2]) }
    it { expect(response).to render_template(:index) }
    it { is_expected.to respond_with :ok }
    it { is_expected.to respond_with_content_type :json }
  end

  describe 'GET show' do
    context 'existing applicant' do
      with :applicant
      before do
        get :show, id: applicant.id
      end

      it { expect(assigns(:applicant)).to eq(applicant) }
      it { expect(response).to render_template(:show) }
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :json }
    end

    context 'non-existing applicant' do
      before do
        get :show, id: 0
      end

      it { is_expected.to respond_with :not_found }
      it { is_expected.to respond_with_content_type :json }
    end
  end

  describe 'POST #create' do
    it { expect{post :create, applicant: attributes_for(:applicant)}.to change(Applicant, :count).by(1) }

    context 'when parameters valid' do
      before do
        @applicant_attr=attributes_for(:applicant)
        post :create, applicant: @applicant_attr
      end

      it { expect(assigns(:applicant).name).to eq(@applicant_attr[:name]) }
      it { expect(response).to render_template(:show) }
      it { is_expected.to respond_with :created }
      it { is_expected.to respond_with_content_type :json }
    end

    context 'when parameters invalid' do
      before do
        post :create, applicant: attributes_for(:applicant, email: 'invalid_email')
      end

      it { is_expected.to respond_with :unprocessable_entity }
      it { is_expected.to respond_with_content_type :json }
    end

    context 'when pass nested skill ids' do
      before do
        @skill_1, @skill_2  = [ create(:skill), create(:skill) ]
        post :create, applicant: attributes_for(:applicant, skill_ids: [@skill_1.id, @skill_2.id])
      end

      it { expect(assigns(:applicant).skills).to eq([@skill_1, @skill_2]) }
      it { is_expected.to respond_with :created }
    end

  end

  describe 'PUT #update' do
    with :applicant
    before do
      @applicant_attr=attributes_for(:applicant)
      put :update, id: applicant.id, applicant: @applicant_attr
    end

    it { expect(assigns(:applicant).name).to eq(@applicant_attr[:name]) }
    it { expect(response).to render_template(:show) }
    it { is_expected.to respond_with :ok }
    it { is_expected.to respond_with_content_type :json }

  end

  describe 'DELETE #destroy' do
    with :applicant
    before do
      @applicant=create(:applicant)
      delete :destroy, id: applicant.id
    end

    it { expect{delete :destroy, id: @applicant.id}.to change(Applicant, :count).by(-1) }
    it { expect(response.body).to be_blank }
    it { is_expected.to respond_with :no_content }
  end

end