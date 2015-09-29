Rails.application.config.middleware.use OmniAuth::Builder do
  # GitHub
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET'],
           scope: 'user:email'

  # Google
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
           name: 'google', access_type: 'online', prompt: 'consent'
end
