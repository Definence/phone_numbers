require 'test_helper'

RSpec.describe UsersController, type: :controller do
  describe '#create' do
    let(:user) { build(:user) }
    let(:params) { { user: { email: user[:email], password: '111111' } } }

    before do
      post :create, params: params
    end

    context 'when successful response' do
      it { expect(response).to be_successful }
      it { expect(json.user.email).to eq(user[:email]) }
    end

    context 'when validation error' do
      let(:params) { { user: { email: '', password: '111111' } } }

      it { expect(response.status).to be(422) }
      it { expect(json.errors.email).not_to be_empty }
    end
  end
end
