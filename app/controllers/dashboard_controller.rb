class DashboardController < ApplicationController
  MAX_CONNS_PER_USER = 3
  LIVE_TOKEN_LENGTH = 64

  def index
    unless logged_in?
      self.destination = dashboard_path

      redirect_to login_path
    end
  end

  # noinspection RailsChecklist01
  def live_token
    # if unauthenticated...
    unless logged_in?
      # delete the token
      cookies.delete :live_token

      # return 403
      return head :forbidden
    end

    $redis.select($redis_databases[:concurrent_connections])

    # if there's too many concurrent connections for the user
    if $redis.get(current_user.id).to_i >= MAX_CONNS_PER_USER
      # return 429
      return head :too_many_requests
    end

    # get current live_token cookie
    live_token_cookie = cookies[:live_token]

    # if there is a live_token cookie...
    if live_token_cookie
      # find the token in the DB
      # @type [LiveToken]
      live_token = LiveToken
                       .select(:id, :expires_at)
                       .find_by(token: live_token_cookie)

      # if the token was found and it's not expired, return 200
      if live_token && Time.now < live_token.expires_at
        return head :ok
      end
    end

    # if the current live_token cookie does not exist OR it's expired...
    # generate a new live_token cookie and persist it

    token = SecureRandom.base64(LIVE_TOKEN_LENGTH)[0..LIVE_TOKEN_LENGTH - 1]
    expires_at = 2.hour.from_now

    LiveToken.create!(user: current_user,
                      token: token,
                      ip: request.remote_ip,
                      expires_at: expires_at)

    cookies[:live_token] = { value: token,
                             expires: expires_at,
                             domain: 'saso.dev',
                             httponly: true }

    head :created
  end
end
