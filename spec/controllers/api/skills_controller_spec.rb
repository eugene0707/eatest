require 'rails_helper'

RSpec.describe Api::SkillsController do

  it { is_expected.to rescue_from(ActiveRecord::RecordNotFound) }
  it { is_expected.to rescue_from(ActiveRecord::RecordNotUnique) }
  it { is_expected.to rescue_from(ActionController::ParameterMissing) }

  describe 'GET index' do
    before do
      @skill_1 = create(:skill)
      @skill_2 = create(:skill)
      get :index
    end

    it { expect(assigns(:skills)).to eq([@skill_1, @skill_2]) }
    it { expect(response).to render_template(:index) }
    it { is_expected.to respond_with :ok }
    it { is_expected.to respond_with_content_type :json }
  end

  describe 'GET show' do
    context 'existing skill' do
      with :skill
      before do
        get :show, id: skill.id
      end

      it { expect(assigns(:skill)).to eq(skill) }
      it { expect(response).to render_template(:show) }
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :json }
    end

    context 'non-existing skill' do
      before do
        get :show, id: 0
      end

      it { is_expected.to respond_with :not_found }
      it { is_expected.to respond_with_content_type :json }
    end
  end

  describe 'POST #create' do
    it { expect{post :create, skill: attributes_for(:skill)}.to change(Skill, :count).by(1) }

    context 'when parameters valid' do
      before do
        @skill_attr=attributes_for(:skill)
        post :create, skill: @skill_attr
      end

      it { expect(assigns(:skill).name).to eq(@skill_attr[:name]) }
      it { expect(response).to render_template(:show) }
      it { is_expected.to respond_with :created }
      it { is_expected.to respond_with_content_type :json }
    end

    context 'when parameters invalid' do
      before do
        post :create
      end

      it { is_expected.to respond_with :unprocessable_entity }
      it { is_expected.to respond_with_content_type :json }
    end

    context 'when duplicate name' do
      with :skill
      before do
        post :create, skill: {name: skill.name}
      end

      it { is_expected.to respond_with :unprocessable_entity }
      it { is_expected.to respond_with_content_type :json }
    end

  end

  describe 'PUT #update' do
    with :skill
    before do
      @skill_attr=attributes_for(:skill)
      put :update, id: skill.id, skill: @skill_attr
    end

    it { expect(assigns(:skill).name).to eq(@skill_attr[:name]) }
    it { expect(response).to render_template(:show) }
    it { is_expected.to respond_with :ok }
    it { is_expected.to respond_with_content_type :json }

  end

  describe 'DELETE #destroy' do
    with :skill
    before do
      @skill=create(:skill)
      delete :destroy, id: skill.id
    end

    it { expect{delete :destroy, id: @skill.id}.to change(Skill, :count).by(-1) }
    it { expect(response.body).to be_blank }
    it { is_expected.to respond_with :no_content }
  end

end