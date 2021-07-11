class ApplicationController < ActionController::Base

  private

    require 'resolv'
    
    ## Finds a user by access_token
    def current_user
      @api_key = ApiKey.includes(:user).where(access_token: params[:token]).first
      if @api_key && !@api_key.expired?
        @current_user = @api_key.user
      else
        false
      end
    end

    def source_domain
      # p "REMOTE IP: #{request.remote_ip}"
      Resolv.getname(request.remote_ip)
    rescue => e
      p "EXCEPTION: #{e}"
      nil
    end

    ## Authenticates an access token
    def authenticate_token!
      render json: {message: 'Invalid Token'}, status: 401 unless current_user
    end

    ## Authenticates a source domain
    def authenticate_source_domain!
      # p "SOURCE DOMAIN: #{source_domain}"
      allowed_domains = ENV["ALLOWED_DOMAINS"].try(:split, ",")
      if allowed_domains.nil? || allowed_domains.count == 0 || !allowed_domains.include?(source_domain)
        render json: {message: 'Invalid source domain'}, status: 401
      end
    end

end
