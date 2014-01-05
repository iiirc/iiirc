if Rails.env.test? || Rails.env.development?
  Iiirc::Application.config.secret_key_base = '4d3be691481af163707159464c3e81f6af4a0026a095e1102d183c6e1e7dcdc8e716938da057df0c8925846ff8b5fe223c482bbd00db2a6d3d389a34d0824dc6'
else
  raise "You must set a secret token in ENV['SECRET_TOKEN'] or in config/initializers/secret_token.rb" if ENV['SECRET_TOKEN'].blank?
  Iiirc::Application.config.secret_key_base = ENV['SECRET_TOKEN']
end
