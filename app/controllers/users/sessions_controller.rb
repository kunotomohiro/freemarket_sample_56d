class Users::SessionsController < Devise::SessionsController
  before_action :notice_count,:todo_count, only: [:sign_out_confirm]

  def create
    # 入力値チェック
    if verify_recaptcha
      super
    else
      @message_recaptcha = '選択してください'
      if params[:user][:email].present? && params[:user][:password].present?
        super
      else
        flash[:alert] = 'メールアドレス もしくはパスワードが不正です。'
        render action: :new
        return
      end
    end
  end

  def sign_out_confirm
  end
end