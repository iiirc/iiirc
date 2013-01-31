OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Settings.github.client_id, Settings.github.client_secret
end
