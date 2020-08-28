require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  before do
    @user = create(:user)
    @follow = create(:user)
  end
  

  describe "#create" do
    context '未ログイン状態のとき' do
      it 'フォローできず、ログインページにリダイレクトされること' do
        expect do
          post relationships_path, params: { follow_id: @follow.id }
        end.to change(Relationship.all, :count).by(0)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to '/users/sign_in'
      end
    end
    context 'ログイン状態のとき' do
      it 'フォローすることができ、フォローしたユーザーページにリダイレクトされること' do
        sign_in(@user)
        expect do
          post relationships_path, params: { follow_id: @follow.id }
        end.to change(Relationship.all, :count).by(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to @follow
      end
    end
  end

  describe '#destroy' do
    before do
      @relationship = create(:relationship, user: @user, follow: @follow)
    end
    context '未ログイン状態のとき' do
      it 'フォロー解除することができず、ログインページにリダイレクトされること' do
        expect do
          delete relationship_path(@relationship), params: {follow_id: @follow.id}
        end.to change(Relationship.all, :count).by (0)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to '/users/sign_in'
      end
    end
    context 'ログイン状態のとき' do
      it 'フォローを解除でき、フォローしていたユーザーページにリダイレクトされること' do
        sign_in(@user)
        expect do
          delete relationship_path(@relationship), params: {follow_id: @follow.id}
        end.to change(Relationship.all, :count).by (-1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to @follow
      end
    end
  end
end
