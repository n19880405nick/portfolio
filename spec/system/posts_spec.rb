# frozen_string_literal: true

require 'rails_helper'

describe '投稿', type: :system do
  let!(:user){ create(:user)}
  let!(:other_user){create(:user)}
  let!(:text){ create(:post, user: user)}
  describe '新規投稿画面のテスト' do
    before do
      sign_in user
      visit new_post_path
    end
    context '表示の確認' do
      it '題名入力欄が表示されているか' do
        expect(page).to have_field 'post[title]'
      end
      it '本文入力欄が表示されているか' do
        expect(page).to have_field 'post[contribution]'
      end
    end
    context '投稿処理に関するテスト' do
      before do
        fill_in 'post[title]', with: Faker::Lorem.characters(number:10)
        fill_in 'post[contribution]', with: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa #abc'
      end
      it '投稿として登録されるか' do
        expect{click_on '投稿する'}.to change(user.posts, :count).by(1)
      end
      it '投稿後のリダイレクト先が投稿一覧になっているか' do
        click_on '投稿する'
        expect(current_path).to eq posts_path
      end
      it '#〇〇がタグとして認識されているか' do
        expect{click_on '投稿する'}.to change(Tag.all, :count).by(1)
      end
      it '投稿されたタグがフッターに表示されているか' do
        click_on '投稿する'
        expect(page).to have_link 'abc', href: tag_search_path(Tag.ids)
      end
    end
  end
  describe '投稿一覧画面のテスト' do
    before do
      visit posts_path
    end
    context '表示の確認' do
      it '題名が表示されているか' do
        expect(page).to have_content text.title
      end
      it '詳細画面へのリンクが表示されているか' do
        expect(page).to have_link '', href: post_path(text)
      end
    end
  end
  describe '投稿詳細画面のテスト（非ログイン）' do
    let!(:comment){create(:comment, user: user, post: text)}
    before do
      visit post_path(text.id)
    end
    context '表示の確認' do
      it '題名が表示されているか' do
        expect(page).to have_content text.title
      end
      it '本文が表示されているか' do
        expect(page).to have_content text.contribution
      end
      it '「投稿を編集する」ボタンが表示されていないか' do
        expect(page).not_to have_link '', href: edit_post_path(text.id)
      end
      it 'いいねが表示されているか' do
        expect(page).to have_content "good!"
      end
      it 'コメントが表示されているか' do
        expect(page).to have_content comment.comment
      end
      it '「コメントを削除」ボタンが表示されていないか' do
        expect(page).not_to have_link '', href: post_comment_path(text, comment)
      end
    end
  end
  describe '投稿詳細画面のテスト（ログイン）' do
    let!(:comment){create(:comment, user: user, post: text)}
    before do
      sign_in user
      visit post_path(text.id)
      fill_in 'comment[comment]', with: Faker::Lorem.characters(number:25)
    end
    context '表示の確認' do
      it '「投稿を編集する」ボタンが表示されているか' do
        expect(page).to have_link '', href: edit_post_path(text)
      end
      it '「コメントを削除」ボタンが表示されているか' do
        expect(page).to have_link '', href: post_comment_path(text, comment)
      end
    end
    context 'いいねのテスト' do
      before do
        sign_in user
      end
      it 'いいねを押したら１増える'  do
        expect{
          post post_likes_path(text), xhr: true
        }.to change(user.likes, :count).by(1)
      end
    end
    context 'コメント投稿のテスト' do
      it 'コメント投稿欄が表示されているか' do
        expect(page).to have_field 'comment[comment]'
      end
      it 'コメントととして登録されるか' do
        expect{click_on 'コメントする'}.to change(user.comments, :count).by(1)
      end
    end
  end
  describe '投稿詳細画面のテスト（別ユーザーログイン）' do
    let!(:comment){create(:comment, user: user, post: text)}
    before do
      sign_in other_user
      visit post_path(text.id)
      fill_in 'comment[comment]', with: Faker::Lorem.characters(number:25)
    end
    context '表示の確認' do
      it '「投稿を編集する」ボタンが表示されていないか' do
        expect(page).not_to have_link '', href: edit_post_path(text)
      end
      it '「コメントを削除」ボタンが表示されていないか' do
        expect(page).not_to have_link '', href: post_comment_path(text, comment)
      end
    end
    context 'コメント投稿のテスト' do
      it 'コメント投稿欄が表示されているか' do
        expect(page).to have_field 'comment[comment]'
      end
      it 'コメントととして登録されるか' do
        expect{click_on 'コメントする'}.to change(other_user.comments, :count).by(1)
      end
    end
  end
end