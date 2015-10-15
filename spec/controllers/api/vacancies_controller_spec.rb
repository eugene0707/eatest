require 'rails_helper'

RSpec.describe Api::VacanciesController do

  it { is_expected.to rescue_from(ActiveRecord::RecordNotFound) }
  it { is_expected.to rescue_from(ActiveRecord::RecordNotUnique) }
  it { is_expected.to rescue_from(ActionController::ParameterMissing) }

  describe 'GET index' do
    before do
      @vacancy_1, @vacancy_2  = [ create(:vacancy), create(:vacancy) ]
      get :index
    end

    it { expect(assigns(:vacancies)).to eq([@vacancy_1, @vacancy_2]) }
    it { expect(response).to render_template(:index) }
    it { is_expected.to respond_with :ok }
    it { is_expected.to respond_with_content_type :json }
  end

  describe 'GET show' do
    context 'existing vacancy' do
      with :vacancy
      before do
        get :show, id: vacancy.id
      end

      it { expect(assigns(:vacancy)).to eq(vacancy) }
      it { expect(response).to render_template(:show) }
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :json }
    end

    context 'non-existing vacancy' do
      before do
        get :show, id: 0
      end

      it { is_expected.to respond_with :not_found }
      it { is_expected.to respond_with_content_type :json }
    end
  end

  describe 'POST #create' do
    it { expect{post :create, vacancy: attributes_for(:vacancy)}.to change(Vacancy, :count).by(1) }

    context 'when parameters valid' do
      before do
        @vacancy_attr=attributes_for(:vacancy)
        post :create, vacancy: @vacancy_attr
      end

      it { expect(assigns(:vacancy).name).to eq(@vacancy_attr[:name]) }
      it { expect(response).to render_template(:show) }
      it { is_expected.to respond_with :created }
      it { is_expected.to respond_with_content_type :json }
    end

    context 'when parameters invalid' do
      before do
        post :create, vacancy: attributes_for(:vacancy, email: 'invalid_email')
      end

      it { is_expected.to respond_with :unprocessable_entity }
      it { is_expected.to respond_with_content_type :json }
    end

    context 'when pass nested skill ids' do
      before do
        @skill_1, @skill_2  = [ create(:skill), create(:skill) ]
        post :create, vacancy: attributes_for(:vacancy, skill_ids: [@skill_1.id, @skill_2.id])
      end

      it { expect(assigns(:vacancy).skills).to eq([@skill_1, @skill_2]) }
      it { is_expected.to respond_with :created }
    end

  end

  describe 'PUT #update' do
    with :vacancy
    before do
      @vacancy_attr=attributes_for(:vacancy)
      put :update, id: vacancy.id, vacancy: @vacancy_attr
    end

    it { expect(assigns(:vacancy).name).to eq(@vacancy_attr[:name]) }
    it { expect(response).to render_template(:show) }
    it { is_expected.to respond_with :ok }
    it { is_expected.to respond_with_content_type :json }

  end

  describe 'DELETE #destroy' do
    with :vacancy
    before do
      @vacancy=create(:vacancy)
      delete :destroy, id: vacancy.id
    end

    it { expect{delete :destroy, id: @vacancy.id}.to change(Vacancy, :count).by(-1) }
    it { expect(response.body).to be_blank }
    it { is_expected.to respond_with :no_content }
  end

end