class Api::V1::TestController < ApplicationController

  before_action :authenticate_source_domain!
  before_action :authenticate_token!

  def index
    render 'index'
  end

end