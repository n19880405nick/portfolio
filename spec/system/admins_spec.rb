# frozen_string_literal: true

require 'rails_helper'

describe '管理者' do
  let!(:user){ create(:user)}
  let!(:other_user){create(:user)}
  let!(:post){ create(:post, user: user)}
  describe 'ログイン画面' do

  end
end