class StaticPagesController < ApplicationController
  def home
    @user = current_user if user_signed_in?
  end

  def about
  end

  def philosophy
  end

  def faq
  end

  def prevention
  end

  def links
  end

  def whitepaper
  end
end
