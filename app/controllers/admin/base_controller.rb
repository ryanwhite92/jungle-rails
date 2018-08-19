class Admin::BaseController < ApplicationController
  before_filter :http_basic_authenticate

  private
  def http_basic_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USERNAME'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
