# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Simor::Application.config.secret_key_base = if Rails.env.development? or Rails.env.test?
    'ad30759f4c01dd0536dd1e5249b6abc81ba9251fb3f816784979456d554754e956c3a37ffd90f1d84109d56d0316867cd9b8469ec51fe7e9fd27256a5bfc0852'
  else
    ENV['SECRET_TOKEN']
  end
