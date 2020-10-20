require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user) }

  describe '#show' do
    it '正常にアクセスできること' do
      get user_path(user)
      expect(response).to have_http_status(200)
    end
  end
end
