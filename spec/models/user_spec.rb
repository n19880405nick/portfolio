# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザーモデルのテスト' do
  it "有効な入力内容の保存" do
    expect(FactoryBot.build(:user)).to be_valid
  end
end
