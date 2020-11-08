require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  before do
    @user = create(:user)
    @follow = create(:user)
  end

  describe '#create' do
    context '未ログイン状態のとき' do
      it 'フォローできないこと' do
        expect do
          post relationships_path, params: { follow_id: @follow.id }, xhr: true
        end.to change(Relationship.all, :count).by(0)
      end
    end
    context 'ログイン状態のとき' do
      it 'フォローできること' do
        sign_in(@user)
        expect do
          post relationships_path, params: { follow_id: @follow.id }, xhr: true
        end.to change(Relationship.all, :count).by(1)
      end
    end
  end

  describe '#destroy' do
    before do
      @relationship = create(:relationship, user: @user, follow: @follow)
    end
    context '未ログイン状態のとき' do
      it 'フォロー解除できないこと' do
        expect do
          delete relationship_path(@relationship), params: { follow_id: @follow.id }, xhr: true
        end.to change(Relationship.all, :count).by(0)
      end
    end
    context 'ログイン状態のとき' do
      it 'フォローを解除できること' do
        sign_in(@user)
        expect do
          delete relationship_path(@relationship), params: { follow_id: @follow.id }, xhr: true
        end.to change(Relationship.all, :count).by(-1)
      end
    end
  end
end
