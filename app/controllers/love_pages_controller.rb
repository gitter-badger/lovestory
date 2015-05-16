class LovePagesController < ApplicationController
  before_action :set_user, only: [:facebook]
  before_action :authenticate_user!, only: [:show]
  before_action :set_love_page, only: [:show]
  before_action :set_recent_posts, only: [:show]

  def facebook
    sign_in @user
    redirect_to @user.love_page
  end

  def show
  end

  private

  def set_love_page
    @love_page = current_user.love_page
  end

  def set_recent_posts
    @posts = @love_page.posts
  end

  def set_user
    @user = Account.from_omniauth(omniauth_params)
  end

  def omniauth_params
    {
      uid: omniauth_data.uid,
      email: omniauth_data.info.email || default_email,
      provider: "facebook"
    }
  end

  def omniauth_data
    request.env["omniauth.auth"]
  end

  def default_email
    "#{SecureRandom.hex(5)}@email.com"
  end
end
