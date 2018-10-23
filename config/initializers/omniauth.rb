opts = { scope: 'user:email' }

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Rails.application.secrets.github_client_id, Rails.application.secrets.github_client_secret, opts
end

id_google = "1010175813812-h7vbsv7hm8453ulhah5uspd64brr9m3g.apps.googleusercontent.com"
secret_google = "2reJS3zudIkgMhmc-mc77bKw"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, id_google, secret_google
end

OmniAuth.config.full_host = Rails.env.production? ? "https://calm-temple-37890.herokuapp.com" : "http://localhost:3000"
