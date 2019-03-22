require 'test_helper'

RSpec.describe SessionsController, type: :controller do
  describe '#create' do
    let(:user) { create(:user) }
    let(:params) { { user: { email: user.email, password: user.password } } }

    before do
      post :create, params: params
    end

    context 'when successful response' do
      it { expect(response).to be_successful }
      it { expect(json.auth_token).to eq(user.auth_token) }
    end

    context 'when data provided' do
      let(:params) { { user: { email: 'wrong email', password: user.password } } }

      it { expect(response).not_to be_successful }
      it { expect(json.errors).to eq('wrong data provided') }
    end

    context 'when data provided' do
      let(:params) { { user: { email: user.email, password: 'wrong password' } } }

      it { expect(response).not_to be_successful }
      it { expect(json.errors).to eq('wrong data provided') }
    end
  end

  describe '#destroy' do
    let(:user) { create(:user) }

    before do
      login_user(user)
      delete :destroy
    end

    context 'when successful response' do
      it { expect(response).to be_successful }
    end

    context 'when unauthorized' do
      let(:user) { nil }

      it { expect(response).not_to be_successful }
      it { expect(response.status).to be(401) }
    end
  end
end
