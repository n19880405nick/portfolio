# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザー登録' do
  let!(:user) { create(:user)}
  describe 'トップページのテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
      it 'ヘッダに「新規登録」へのリンクが表示されているか' do
        expect(page).to have_link "新規登録", href: new_user_registration_path
      end
      it 'ヘッダに「ログイン」へのリンクが表示されているか' do
        expect(page).to have_link "ログイン", href: new_user_session_path
      end
    end
  end
end