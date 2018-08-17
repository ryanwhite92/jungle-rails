class Admin::DashboardController < ApplicationController
  before_action :http_basic_authenticate

  def show
  end
end
