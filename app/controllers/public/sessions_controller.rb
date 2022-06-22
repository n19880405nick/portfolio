# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  before_action :user_state, only: [:create]

  protected

  # 退会しているかを判断するメソッド
  def user_state
    ## 【処理内容１】入力されたemailからアカウントを1件取得
    @user = User.find_by(email: params[:user][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@user
    ## 【処理内容２】取得したアカウントのパスワードと入力されたパスワードが一致しているかを判別
    if @user.valid_password?(params[:user][:password])
      ## 【処理内容３】処理２がtrueかつ退会カラムの真偽にて、場合分け
      if true && @user.is_active == !true
        ## 退会していたらサインアップ画面へ
        redirect_to new_user_registration_path
      end
      ## 退会していない場合はアクション続行
    end
  end
end
