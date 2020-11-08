require 'rails_helper'

RSpec.describe 'Records', type: :request do
  let(:user) { create(:user) }
  let(:deny_user) { create(:user, records_is_released: false) }
  let(:other) { create(:user) }
  let(:record) { create(:record) }
  let(:training_menu) { create(:training_menu) }

  describe '#index' do
    it '正常にアクセスできること' do
      get user_records_path(user)
      expect(response).to have_http_status(200)
    end
    it '非公開設定の場合、トップページにリダイレクトされること' do
      get user_records_path(deny_user)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end
  end

  describe '#new' do
    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクトされること' do
        get new_user_record_path(user)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_session_path
      end
    end
    context '記録ページ本人でログイン状態のとき' do
      before { sign_in(user) }
      it '正常にアクセスできること' do
        get new_user_record_path(user)
        expect(response).to have_http_status(200)
      end
    end
    context '記録ページ本人以外でログイン状態のとき' do
      before { sign_in(other) }
      it 'レコードトップページにリダイレクトされること' do
        get new_user_record_path(user)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_records_path(user)
      end
    end
  end

  describe '#show' do
    it '正常にアクセスできること' do
      get user_record_path(user_id: user, id: record)
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    context '未ログイン状態のとき' do
      it '記録できないこと' do
        record_params = attributes_for(:record, training_menus_attributes:[ attributes_for(:training_menu)])
        expect do
          post user_records_path(user), params: { record: record_params }
        end.to change(Record.all, :count).by(0)
      end
      it 'ログインページにリダイレクトされること' do
        record_params = attributes_for(:record, training_menus_attributes:[ attributes_for(:training_menu)])
        post user_records_path(user), params: { record: record_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_session_path
      end
    end
    context '記録ページ本人でログイン状態のとき' do
      before { sign_in(user) }
      it '正常に記録できること' do
        record_params = attributes_for(:record, training_menus_attributes:[ attributes_for(:training_menu)])
        expect do
          post user_records_path(user), params: { record: record_params }
        end.to change(Record.all, :count).by(1)
      end
      it 'レコードトップページにリダイレクトされること' do
        record_params = attributes_for(:record, training_menus_attributes:[ attributes_for(:training_menu)])
        post user_records_path(user), params: { record: record_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_records_path(user)
      end
      it '記録失敗時、記録作成ページがレンダリングされること' do
        record_params = attributes_for(:record, start_time: nil)
        post user_records_path(user), params: { record: record_params }
        expect(response).to have_http_status(200)
        expect(response).to render_template :new
      end
    end
    context '記録ページ本人以外でログイン状態のとき' do
      before { sign_in(other) }
      it '記録できないこと' do
        record_params = attributes_for(:record)
        expect do
          post user_records_path(user), params: { record: record_params }
        end.to change(Record.all, :count).by(0)
      end
      it 'レコードトップページにリダイレクトされること' do
        record_params = attributes_for(:record)
        post user_records_path(user), params: { record: record_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_records_path(user)
      end
    end
  end

  describe '#destroy' do
    before { @record = create(:record, user: user) }
    context '未ログイン状態のとき' do
      it 'トレーニング記録を削除できないこと' do
        expect do
          delete user_record_path(user_id: user, id: @record)
        end.to change(Record.all, :count).by(0)
      end
      it 'ログインページにリダイレクトされること' do
        delete user_record_path(user_id: user, id: @record)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_session_path
      end
    end
    context '記録ページ本人でログイン状態のとき' do
      before { sign_in(user) }
      it '記録を削除できること' do
        expect do
          delete user_record_path(user_id: user, id: @record)
        end.to change(Record.all, :count).by(-1)
      end
      it 'レコードトップページにリダイレクトされること' do
        delete user_record_path(user_id: user, id: @record)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_records_path(user)
      end
    end
    context '記録ページ本人以外でログイン状態のとき' do
      before { sign_in(other) }
      it '記録を削除できないこと' do
        expect do
          delete user_record_path(user_id: user, id: @record)
        end.to change(Record.all, :count).by(0)
      end
      it 'レコードトップページにリダイレクトされること' do
        delete user_record_path(user_id: user, id: @record)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_records_path(user)
      end
    end
  end

  describe '#edit' do
    before { @record = create(:record, user: user) }
    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクトされること' do
        get edit_user_record_path(user_id: user, id: @record)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_session_path
      end
    end
    context '記録ページ本人でログイン状態のとき' do
      before { sign_in(user) }
      it '正常にアクセスできること' do
        get edit_user_record_path(user_id: user, id: @record)
        expect(response).to have_http_status(200)
      end
    end
    context '記録ページ本人以外でログイン状態のとき' do
      before { sign_in(other) }
      it 'レコードトップページにリダイレクトされること' do
        get edit_user_record_path(user_id: user, id: @record)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_records_path(user)
      end
    end
  end

  describe 'update' do
    before { @record = create(:record, user: user) }
    context '未ログイン状態のとき' do
      it 'トレーニング記録を更新できないこと' do
        record_params = attributes_for(:record, main_target: '三角筋')
        patch user_record_path(user_id: user, id: @record), params: { record: record_params }
        @record.reload
        expect(@record.main_target).not_to eq('三角筋')
      end
      it 'ログインページにリダイレクトされること' do
        record_params = attributes_for(:record, main_target: '三角筋')
        patch user_record_path(user_id: user, id: @record), params: { record: record_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_session_path
      end
    end
    context '記録ページ本人でログイン状態のとき' do
      before { sign_in(user) }
      it '記録を更新できること' do
        record_params = attributes_for(:record, main_target: '三角筋')
        patch user_record_path(user_id: user, id: @record), params: { record: record_params }
        @record.reload
        expect(@record.main_target).to eq('三角筋')
      end
      it 'レコードトップページにリダイレクトされること' do
        record_params = attributes_for(:record, main_target: '三角筋')
        patch user_record_path(user_id: user, id: @record), params: { record: record_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_records_path(user)
      end
      it '更新失敗時、編集画面がレンダリングされること' do
        record_params = attributes_for(:record, start_time: '')
        patch user_record_path(user_id: user, id: @record), params: { record: record_params }
        expect(response).to have_http_status(200)
        expect(response).to render_template :edit
      end
    end
    context '記録ページ本人以外でログイン状態のとき' do
      before { sign_in(other) }
      it '記録を更新できないこと' do
        record_params = attributes_for(:record, main_target: '三角筋')
        patch user_record_path(user_id: user, id: @record), params: { record: record_params }
        @record.reload
        expect(@record.main_target).not_to eq('三角筋')
      end
      it 'レコードトップページにリダイレクトされること' do
        record_params = attributes_for(:record, main_target: '三角筋')
        patch user_record_path(user_id: user, id: @record), params: { record: record_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_records_path(user)
      end
    end
  end
end
