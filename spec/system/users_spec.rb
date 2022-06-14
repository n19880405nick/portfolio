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
      it '「投稿一覧」へのリンクが表示されているか' do
        expect(page).to have_link "", href: posts_path
      end
    end
  end
  describe '新規登録画面のテスト' do
    before do
      visit new_user_registration_path
    end
    context '表示の確認' do
      it '名前入力欄が表示されているか' do
        expect(page).to have_field 'user[name]'
      end
      it 'メールアドレス入力欄が表示されているか' do
        expect(page).to have_field 'user[email]'
      end
      it 'パスワード入力欄が表示されているか' do
        expect(page).to have_field 'user[password]'
      end
      it 'パスワード確認入力欄が表示されているか' do
        expect(page).to have_field 'user[password_confirmation]'
      end
    end
    context '新規登録処理に関するテスト' do
      before do
        fill_in 'user[name]', with: Faker::Name.name
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end
      it 'ユーザーとして登録されるか' do
        expect{click_button '新規登録する'}.to change(User.all, :count).by(1)
      end
      it '登録後のリダイレクト先がマイページになっているか' do
        click_button '新規登録する'
        expect(current_path).to eq my_page_path
      end
    end
  end
end