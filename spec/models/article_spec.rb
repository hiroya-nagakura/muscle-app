require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { create(:user) }
  let(:article) { create(:article) }

  it "有効なファクトリを持つこと" do
    expect { create(:article) }.to change(Article.all, :count).by(1)
  end
end
