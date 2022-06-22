# frozen_string_literal: true

require 'rails_helper'

describe '管理者' do
  let!(:admin){ create(:admin)}
  let!(:user){ create(:user)}
  let!(:other_user){create(:user)}
  let!(:post){ create(:post, user: user)}
  let!(:other_post){create(:post, user: other_user)}
  let!(:comment){ create(:comment, post: post, user: user)}
  describe 'ログイン画面' do
    before do
      visit new_admin_session_path
    end
    context '表示の確認' do
      it 'アドレス入力欄が表示されているか' do
        expect(page).to have_field 'admin[email]'
      end
      it 'パスワード入力欄が表示されているか' do
        expect(page).to have_field 'admin[password]'
      end
    end
    context 'ログイン処理に関するテスト' do
      before do
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'ログインする'
      end
      it 'ログイン後のリダイレクト先が、管理者トップページになっているか' do
        expect(current_path).to eq admin_top_path
      end
    end
  end
  describe '管理者トップページ（投稿一覧）のテスト' do
    before do
      sign_in admin
      visit admin_top_path
    end
    context '表示の確認' do
      it 'ユーザー氏名が表示され、それが「ユーザーごとの投稿一覧」リンクになっているか' do
        expect(page).to have_link post.user.name, href: admin_user_posts_path(user)
        expect(page).to have_link other_post.user.name, href: admin_user_posts_path(other_user)
      end
      it '題名が表示され、それが「投稿詳細」リンクになっているか' do
        expect(page).to have_link post.title, href: admin_post_path(post)
        expect(page).to have_link other_post.title, href: admin_post_path(other_post)
      end
      it 'ヘッダに「ユーザー一覧」リンクが表示されているか' do
        expect(page).to have_link 'ユーザー一覧', href: admin_users_path
      end
      it 'ヘッダに「投稿一覧」リンクが表示されているか' do
        expect(page).to have_link '投稿一覧', href: admin_top_path
      end
      it 'ヘッダに「管理者ログアウト」リンクが表示されているか' do
        expect(page).to have_link '管理者ログアウト', href: destroy_admin_session_path
      end
    end
  end
  describe 'ユーザーごとの投稿一覧画面のテスト' do
    before do
      sign_in admin
      visit admin_user_posts_path(user)
    end
    context '表示の確認' do
      it 'ユーザー氏名が表示され、それが「ユーザー詳細画面」リンクになっているか' do
        expect(page).to have_link user.name, href: admin_user_path(user)
      end
      it '題名が表示され、それが「投稿詳細」リンクになっているか' do
        expect(page).to have_link post.title, href: admin_post_path(post)
      end
    end
  end
  describe 'ユーザー一覧画面のテスト' do
    before do
      sign_in admin
      visit admin_users_path
    end
    context '表示の確認' do
      it 'ユーザー氏名が表示され、それが「ユーザー詳細画面」リンクになっているか' do
        expect(page).to have_link user.name, href: admin_user_path(user)
      end
      it 'ユーザーステータスに「有効」が表示されているか' do
        expect(page).to have_content '有効'
      end
    end
  end
  describe 'ユーザー詳細画面のテスト' do
    before do
      sign_in admin
      visit admin_user_path(user)
    end
    context '表示の確認' do
      it 'ユーザー氏名が表示されているか' do
        expect(page).to have_content user.name
      end
      it 'ユーザーのアドレスが表示されているか' do
        expect(page).to have_content user.email
      end
      it 'ユーザーステータスに「有効」が表示されているか' do
        expect(page).to have_content '有効'
      end
      it '「ユーザー編集画面」へのリンクが表示されているか' do
        expect(page).to have_link '', href: edit_admin_user_path(user)
      end
    end
  end
  describe 'ユーザー編集画面のテスト' do
    before do
      sign_in admin
      visit edit_admin_user_path(user)
    end
    context '表示の確認' do
      it 'ユーザー名編集欄が表示されているか' do
        expect(page).to have_field 'user[name]'
      end
      it 'ユーザーアドレス編集欄が表示されているか' do
        expect(page).to have_field 'user[email]'
      end
      it 'ユーザーステータス変更ラジオボタンが表示されているか（有効が選択されているか）' do
        expect(page).to have_checked_field('有効')
      end
    end
    context '変更処理のテスト' do
      it 'ユーザーステータスを退会に変更できるか' do
        choose '退会'
        click_on '編集を保存する'
        expect(page).to have_content '退会'
      end
    end
  end
  describe '投稿詳細画面のテスト' do
    before do
      sign_in admin
      visit admin_post_path(post)
    end
    context '表示の確認' do
      it '「投稿を削除」ボタンが表示されているか' do
        expect(page).to have_link '投稿を削除', href: admin_post_path(post)
      end
      it '投稿が表示されているか' do
        expect(page).to have_content post.title
      end
      it 'コメントが表示されているか' do
        expect(page).to have_content comment.comment
      end
      it '「コメント削除」ボタンが表示されているか' do
        expect(page).to have_link 'コメント削除', href: admin_post_comment_path(post, comment)
      end
    end
  end
end