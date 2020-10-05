require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user) }
  let(:favorite) { create(:favorite) }

  it '有効なファクトリを持つこと' do
    expect { create(:favorite) }.to change(Favorite.all, :count).by(1)
  end
end
