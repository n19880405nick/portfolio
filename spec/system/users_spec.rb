# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザー' do
  let!(:user) { create(:user)}
  let!(:post) { create(:post, user: user)}
  let!(:like) { create(:like, user: user, post: post)}
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
  describe 'ログイン画面のテスト' do
    before do
      visit new_user_session_path
    end
    context '表示の確認' do
      it 'メールアドレス入力欄が表示されているか' do
        expect(page).to have_field 'user[email]'
      end
      it 'パスワード入力欄が表示されているか' do
        expect(page).to have_field 'user[password]'
      end
    end
    context 'ログイン処理に関するテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end
      it 'ログイン後のリダイレクト先がマイページになっているか' do
        expect(current_path).to eq my_page_path
      end
    end
    context 'ログイン後のヘッダに関するテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end
      it 'ヘッダに「マイページ」リンクが表示されているか' do
        expect(page).to have_link "マイページ", href: my_page_path
      end
      it 'ヘッダに「新規投稿」リンクが表示されているか' do
        expect(page).to have_link "新規投稿", href: new_post_path
      end
      it 'ヘッダに「投稿一覧」リンクが表示されているか' do
        expect(page).to have_link "投稿一覧", href: posts_path
      end
      it 'ヘッダに「ログアウト」リンクが表示されているか' do
        expect(page).to have_link "ログアウト", href: destroy_user_session_path
      end
      it 'ログアウト後のリダイレクト先がトップページになっているか' do
        click_on 'ログアウト'
        expect(current_path).to eq root_path
      end
    end
  end
  describe 'マイページのテスト' do
    before do
      sign_in user
      visit my_page_path
      @calendar = Calendar.new(user: user, sleeping_time: 1, day: Time.now.day, month: Time.now.month)
    end
    context '表示の確認' do
      it '名前が表示されているか' do
        expect(page).to have_content user.name
      end
      it 'メールアドレスが表示されているか' do
        expect(page).to have_content user.email
      end
      it '「ユーザー編集」へのリンクがあるか' do
        expect(page).to have_link '', href: edit_user_path(user)
      end
      it 'カレンダーが表示されているか' do
        expect(page).to have_content Time.now.month
      end
      it '睡眠時間のセレクトボックスがあるか' do
        expect(page).to have_field 'calendar[sleeping_time]'
      end
      it '選択して睡眠時間がカレンダーに反映されているか' do

      end
    end
  end
end