require 'rails_helper'

RSpec.describe 'Bodyweights', type: :request do
  let(:user) { create(:user) }
  let(:deny_user) { create(:user, bodyweights_is_released: false) }
  let(:other) { create(:user) }
  let(:bodyweight) { create(:bodyweight) }

  describe '#index' do
    it '正常にアクセスできること' do
      get user_bodyweights_path(user)
      expect(response).to have_http_status(200)
    end
    it '非公開設定の場合トップページにリダイレクトされること' do
      get user_bodyweights_path(deny_user)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end
  end

  describe '#create' do
    context '未ログイン状態のとき' do
      it '記録できないこと' do
        bodyweight_params = attributes_for(:bodyweight)
        expect do
          post user_bodyweights_path(user), params: { bodyweight: bodyweight_params }
        end.to change(Bodyweight.all, :count).by(0)
      end
      it 'ログインページにリダイレクトされること' do
        bodyweight_params = attributes_for(:bodyweight)
        post user_bodyweights_path(user), params: { bodyweight: bodyweight_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_session_path
      end
    end
    context '記録ページ本人でログイン状態のとき' do
      before { sign_in(user) }
      it '正常に記録できること' do
        bodyweight_params = attributes_for(:bodyweight)
        expect do
          post user_bodyweights_path(user), params: { bodyweight: bodyweight_params }
        end.to change(Bodyweight.all, :count).by(1)
      end
      it '体重記録トップページにリダイレクトされること' do
        bodyweight_params = attributes_for(:bodyweight)
        post user_bodyweights_path(user), params: { bodyweight: bodyweight_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_bodyweights_path(user)
      end
      it '記録失敗時、体重記録トップページにリダイレクトされること' do
        bodyweight_params = attributes_for(:bodyweight, weight: nil)
        post user_bodyweights_path(user), params: { bodyweight: bodyweight_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_bodyweights_path(user)
      end
    end
    context '記録ページ本人以外でログイン状態のとき' do
      before { sign_in(other) }
      it '記録できないこと' do
        bodyweight_params = attributes_for(:bodyweight)
        expect do
          post user_bodyweights_path(user), params: { bodyweight: bodyweight_params }
        end.to change(Bodyweight.all, :count).by(0)
      end
      it '体重記録トップページにリダイレクトされること' do
        bodyweight_params = attributes_for(:bodyweight)
        post user_bodyweights_path(user), params: { bodyweight: bodyweight_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_bodyweights_path(user)
      end
    end
  end

  describe '#update' do
    before { @bodyweight = create(:bodyweight, user: user) }
    context '未ログイン状態のとき' do
      it '編集できないこと' do
        bodyweight_params = attributes_for(:bodyweight, weight: 80)
        patch user_bodyweight_path(user_id: user, id: @bodyweight), params: { bodyweight: bodyweight_params }
        @bodyweight.reload
        expect(@bodyweight.weight).not_to eq(80)
      end
      it 'ログインページにリダイレクトされること' do
        bodyweight_params = attributes_for(:bodyweight, weight: 80)
        patch user_bodyweight_path(user_id: user, id: @bodyweight), params: { bodyweight: bodyweight_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_session_path
      end
    end
    context '記録ページ本人でログイン状態のとき' do
      before { sign_in(user) }
      it '正常に編集できること' do
        bodyweight_params = attributes_for(:bodyweight, weight: 80)
        patch user_bodyweight_path(user_id: user, id: @bodyweight), params: { bodyweight: bodyweight_params }
        @bodyweight.reload
        expect(@bodyweight.weight).to eq(80)
      end
      it '体重記録トップページにリダイレクトされること' do
        bodyweight_params = attributes_for(:bodyweight, weight: 80)
        patch user_bodyweight_path(user_id: user, id: @bodyweight), params: { bodyweight: bodyweight_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_bodyweights_path(user)
      end
      it '編集失敗時、体重記録トップページにリダイレクトされること' do
        bodyweight_params = attributes_for(:bodyweight, weight: nil)
        patch user_bodyweight_path(user_id: user, id: @bodyweight), params: { bodyweight: bodyweight_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_bodyweights_path(user)
      end
    end
    context '記録ページ本人以外でログイン状態のとき' do
      before { sign_in(other) }
      it '編集できないこと' do
        bodyweight_params = attributes_for(:bodyweight, weight: 80)
        patch user_bodyweight_path(user_id: user, id: @bodyweight), params: { bodyweight: bodyweight_params }
        @bodyweight.reload
        expect(@bodyweight.weight).not_to eq(80)
      end
      it '体重記録トップページにリダイレクトされること' do
        bodyweight_params = attributes_for(:bodyweight, weight: nil)
        patch user_bodyweight_path(user_id: user, id: @bodyweight), params: { bodyweight: bodyweight_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_bodyweights_path(user)
      end
    end
  end

  describe '#destroy' do
    before { @bodyweight = create(:bodyweight, user: user) }
    context '未ログイン状態のとき' do
      it '記録を削除できないこと' do
        expect do
          delete user_bodyweight_path(user_id: user, id: @bodyweight)
        end.to change(Bodyweight.all, :count).by(0)
      end
      it 'ログインページにリダイレクトされること' do
        delete user_bodyweight_path(user_id: user, id: @bodyweight)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_session_path
      end
    end
    context '記録ページ本人でログイン状態のとき' do
      before { sign_in(user) }
      it '正常に削除できること' do
        expect do
          delete user_bodyweight_path(user_id: user, id: @bodyweight)
        end.to change(Bodyweight.all, :count).by(-1)
      end
      it '体重記録トップページにリダイレクトされること' do
        delete user_bodyweight_path(user_id: user, id: @bodyweight)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_bodyweights_path(user)
      end
    end
    context '記録ページ本人以外でログイン状態のとき' do
      before { sign_in(other) }
      it '記録を削除できないこと' do
        expect do
          delete user_bodyweight_path(user_id: user, id: @bodyweight)
        end.to change(Bodyweight.all, :count).by(0)
      end
      it '体重記録トップページにリダイレクトされること' do
        delete user_bodyweight_path(user_id: user, id: @bodyweight)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_bodyweights_path(user)
      end
    end
  end
end
