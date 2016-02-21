class StaticPagesController < ApplicationController
  before_action :set_static_page, only: [:show, :edit, :update, :destroy]
  skip_before_filter :ensure_login

  def about
  end

end
