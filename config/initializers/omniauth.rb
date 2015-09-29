Rails.application.config.middleware.use OmniAuth::Builder do

  # GitHub
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET'],
           scope: 'user:email'

  # Google
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
           name: 'google', access_type: 'online', prompt: 'consent'

  # Twitter
  provider :twitter, ENV['TWITTER_CLIENT_ID'], ENV['TWITTER_CLIENT_SECRET'],
           secure_image_url: true, x_auth_access_type: 'read'

  # DigitalOcean
  provider :digitalocean, ENV['DIG_OC_CLIENT_ID'], ENV['DIG_OC_CLIENT_SECRET'],
           scope: 'read'

end
