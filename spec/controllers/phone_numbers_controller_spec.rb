require 'test_helper'

RSpec.describe PhoneNumbersController, type: :controller do
  describe '#create' do
    let(:user) { create(:user) }
    let(:params) { { number: { value: 1111111111 } } }

    before do
      login_user(user)
      post :create, params: params
    end

    context 'when successful response' do
      it { expect(json.number.number).to eq('1111111111') }
    end

    context 'when unauthorized' do
      let(:user) { nil }

      it { expect(response).not_to be_successful }
      it { expect(response.status).to be(401) }
    end

    context 'when uniqueness error' do
      it { expect(response).not_to be_successful }
      it { expect(response.status).to be(422) }
      it { expect(json.errors.number[0]).not_to eq('has already_been_taken') }
    end

    context 'when validation error' do
      let(:params) { { number: { value: '' } } }

      it { expect(response).not_to be_successful }
      it { expect(response.status).to be(422) }
      it { expect(json.errors.number).not_to be_empty }
    end
  end
end
